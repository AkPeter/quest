class RobokassaController < ApplicationController
  skip_before_action :verify_authenticity_token
  RESERVE_TIME = 15.minutes

  def index
    session[:tid] = nil
  end

  def prepay
    @ticket = current_ticket
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

  end

  def paid_confirmed
    # пользователь оплатил в робокассе, надо сверить что он там оплатил
    ticket = Ticket.find(current_ticket)

    out_sum = ticket.price.to_f
    inv_id = ticket.id.to_i

    render text: "OK#{inv_id}"

=begin
    if params[:OutSum].to_f >= out_sum  && params[:InvId].to_i == inv_id && params[:SignatureValue] == Digest::MD5.new << "#{out_sum}:#{inv_id}:#{Rails.application.secrets.robokassa_password2}"
      #котирую оплату пользователем и я говорю Окей .)
      if ticket.update(ticket_status_id: 3)
        render text: "OK#{inv_id}"
      else
        render text: 'SHITHAPPENS'
      end
    else
      # 8======>
      # резерв снимается по истечении времени резерва, но не тут
      render text: 'SHITHAPPENS'
    end
=end
  end

  def transaction_confirmed
    # всё прошло успешно - можно потрепать пользователя по плечу
    if current_ticket.id == 3
      @ticket = current_ticket
      session[:tid] = nil
      UserMailer.ticket_purchased(@ticket).deliver_now

      # снаряжаем фоновую задачу правильным образом ! ну и рассылка будет если ещё не поздно рассылать )
      time2remind = @ticket.dt.to_datetime - TicketsController::UserRemindBefore
      TicketUserRemindJob.set(wait_until: time2remind).perform_later(@ticket.id, current_user.id) if DateTime.now < time2remind
    end

  end

  def abort_mission
    # чёт не то, пусть разбирается дальше, пока резерв не истёк
    redirect_to payment_url
  end

end