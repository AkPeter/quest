class SmsController < ApplicationController

    def new_bee (user, password)
      message = "твой пароль на #{ApplicationController::Domain} #{password}"
      send user.phone, message
    end

    def password_reset(user, new_password)
      message = "твой новый пароль на #{ApplicationController::Domain} #{new_password}"
      send user.phone, message
    end

    def ticket_reserved(ticket)
      message = "билет на квест #{ticket.quest_item.name} сеанс #{l(ticket.dt.to_datetime, :format => "%d %B %A %H:%M")} зарезервирован. время резерва #{RobokassaController::RESERVE_TIME} минут"
      send ticket.user.phone, message
    end

    def ticket_purchased(ticket)
      message = "приобретён билет на квест #{ticket.quest_item.name} сеанс #{l(ticket.dt.to_datetime, :format => "%d %B %A %H:%M")}"
      send ticket.user.phone, message
    end

    def ticket_remind(ticket)
      message = "скоро начало, не пропусти, сеанс #{l(ticket.dt.to_datetime, :format => "%d %B %A %H:%M")} квест #{ticket.quest_item.name}"
      send ticket.user.phone, message
    end

    private
    def send (recepient_10dgt, message)
      message.sms recepient_10dgt
    end

end