module SmsLib

  def sms_new_bee(user, password)
    message = "твой пароль на #{ApplicationController::Domain} #{password}"
    send_sms user.phone, message
  end

  def sms_password_reset(user, new_password)
    message = "твой новый пароль на #{ApplicationController::Domain} #{new_password}"
    send_sms user.phone, message
  end

  def sms_ticket_reserved(ticket)
    message = "билет на квест #{ticket.quest_item.name} сеанс #{l(ticket.dt.to_datetime, :format => "%d %B %A %H:%M")} зарезервирован. время резерва #{RobokassaController::RESERVE_TIME} минут"
    send_sms ticket.user.phone, message
  end

  def sms_ticket_purchased(ticket)
    message = "приобретён билет на квест #{ticket.quest_item.name} сеанс #{l(ticket.dt.to_datetime, :format => "%d %B %A %H:%M")}"
    send_sms ticket.user.phone, message
  end

  def sms_ticket_remind(ticket)
    message = "скоро начало, не пропусти, сеанс #{l(ticket.dt.to_datetime, :format => "%d %B %A %H:%M")} квест #{ticket.quest_item.name}"
    send_sms ticket.user.phone, message
  end

  private

  def send_sms(recepient_10dgt, message)
    require 'russland_sms'

    message.sms recepient_10dgt
  end

end