class RobokassaController < ApplicationController
  skip_before_action :verify_authenticity_token
  RESERVE_TIME = 15.minutes

  def index
    session[:tid] = nil
  end

  def prepay
    @ticket = current_ticket
    unless @ticket
      redirect_to root_url
    else
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

  end

  def try
    _layout = false

    require 'uri'
    require 'net/http'
    setup = {
        :smsru => {
            :uri => 'http://lockinroom.ru/paid_confirmed',
            :params => {
                :api_id => Rails.application.secrets.sms_ru_api_key,
            }
        }
    }

    uri = URI setup[:smsru][:uri]
    uri.query = URI.encode_www_form setup[:smsru][:params]

    Net::HTTP.get_response uri
  end

  def paid_confirmed
    _layout = false
    # пользователь оплатил в робокассе, надо сверить что он там оплатил
    tickets = Ticket.where('user_id=? and ticket_status_id=?', session[:uid], 2)
    if tickets.any?
      ticket = tickets.first

      out_sum = ticket.price.to_f
      inv_id = ticket.id.to_i

      if params[:OutSum].to_f >= out_sum  && params[:InvId].to_i == inv_id && params[:SignatureValue] == Digest::MD5.new << "#{out_sum}:#{inv_id}:#{Rails.application.secrets.robokassa_password2}"
        #котирую оплату пользователем и я говорю Окей .)
        session[:ptid] = ticket.id
        render text: ticket.update(ticket_status_id: 3) ? "OK#{inv_id}" : 'SHITHAPPENS'
      else
        # 8======>
        # резерв снимается по истечении времени резерва, но не тут
        render text: 'SHITHAPPENS'
      end
    end
  end

  def transaction_confirmed
    # всё прошло успешно - можно потрепать пользователя по плечу
    # снаряжаем фоновую задачу правильным образом ! ну и рассылка будет если ещё не поздно рассылать )
    if purshased_ticket
      @ticket = purshased_ticket
      session[:tid] = nil
      session[:ptid] = nil
      UserMailer.ticket_purchased(@ticket).deliver_now

      # снаряжаем фоновую задачу правильным образом ! ну и рассылка будет если ещё не поздно рассылать )
      time2remind = @ticket.dt.to_datetime - TicketsController::UserRemindBefore
      TicketUserRemindJob.set(wait_until: time2remind).perform_later(@ticket.id, current_user.id) if DateTime.now < time2remind
    else
      # маленький хакер ) иди оплачивай ! )
      redirect_to payment_url
    end
  end

  def abort_mission
    # чёт не то, пусть разбирается дальше, пока резерв не истёк
    redirect_to payment_url
  end

end