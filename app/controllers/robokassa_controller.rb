class RobokassaController < ApplicationController
  layout false, only: [:paid_confirmed, :transaction_confirmed, :abort_mission]

  skip_before_action :verify_authenticity_token
  RESERVE_TIME = 15.minutes

  def prepay
    if current_ticket
      @ticket = current_ticket
      session[:tid] = @ticket.id
      out_sum = @ticket.price.to_f
      inv_id = @ticket.id.to_i

      @params = {
          :mrch_login => Rails.application.secrets.robokassa_mrch_login,
          :out_sum => out_sum,
          :inv_id => inv_id,
          :desc => "#{@ticket.quest_item.name} начало #{l(@ticket.dt.to_datetime, :format => "%d %B %A %H:%M")}",
          :password1 => Rails.application.secrets.robokassa_password1,
          :signature_value => Digest::MD5.new << "#{Rails.application.secrets.robokassa_mrch_login}:#{out_sum}:#{inv_id}:#{Rails.application.secrets.robokassa_password1}",
          :culture => 'ru'
      }
    else
      redirect_to root_url, notice: 'резерв билета истёк'
    end


  end

  def paid_confirmed
    # пользователь оплатил в робокассе, надо сверить что он там оплатил
    tickets = Ticket.where('id=? and ticket_status_id=?', params[:InvId].to_i, 2)

    if tickets.any?
      ticket = tickets.first

      out_sum = ticket.price.to_f
      inv_id = ticket.id.to_i

      if params[:OutSum].to_f >= out_sum  && params[:InvId].to_i == inv_id && params[:SignatureValue] == (Digest::MD5.new << "#{out_sum}:#{inv_id}:#{Rails.application.secrets.robokassa_password2}").to_s.upcase
        #котирую оплату пользователем и я говорю Окей .)
        render text: ticket.update(ticket_status_id: 3) ? "OK#{inv_id}" : 'SHITHAPPENS'
      else
        # 8======>
        # резерв снимается по истечении времени резерва, но не тут
        render text: 'SHITHAPPENS'
      end
    else
      render text: 'SHITHAPPENS'
    end
  end


  def transaction_confirmed
    # всё прошло успешно - можно потрепать пользователя по плечу
    # снаряжаем фоновую задачу правильным образом ! ну и рассылка будет если ещё не поздно рассылать )
    tickets = Ticket.where('id=? and ticket_status_id=?', params[:InvId].to_i, 3)
    if tickets.any?
      ticket = tickets.first

      UserMailer.ticket_purchased(ticket, false).deliver_now

      # снаряжаем фоновую задачу правильным образом ! ну и рассылка будет если ещё не поздно рассылать )
      time2remind = ticket.dt.to_datetime - TicketsController::UserRemindBefore
      TicketUserRemindJob.set(wait_until: time2remind).perform_later(ticket.id, current_user.id) if DateTime.now < time2remind

      session[:tid] = nil

      redirect_to action: :purchase_complete, id: ticket
    else
      # маленький хакер ) иди оплачивай ! )
      redirect_to payment_url, notice: 'билет не оплачен'
    end
  end

  def abort_mission
    # чёт не то, пусть разбирается дальше, пока резерв не истёк )
    redirect_to action: :purchase_aborted
  end

  def purchase_complete
    tickets = Ticket.where('id=?', params[:id].to_i)
    if tickets.any?
      @ticket = tickets.first
    end
  end

  def purchase_aborted

  end

end