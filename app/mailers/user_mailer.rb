class UserMailer < ApplicationMailer

  def new_bee(user, password)
    @username = user.name
    @signin  = 'http://telegus.ru'
    @password = password

    mail(to: user.email, subject: 'Дворников - Квестов. С подключением !')
  end

  def password_reset(user, new_password)
    @username = user.name
    @signin  = 'http://telegus.ru'
    @new_password = new_password

    mail(to: user.email, subject: 'Дворников - Квестов. Новый пароль для входа')
  end

  def ticket_reserved(ticket)
    @signin  = 'http://telegus.ru'
    @ticket = ticket
    @reserve_time = RobokassaController::RESERVE_TIME
    mail(to: ticket.user.email, subject: 'Дворников - Квестов. Резерв билета.')
  end

  def ticket_purchased(ticket)
    @ticket = ticket
    mail(to: ticket.user.email, subject: 'Дворников - Квестов. Ты приобрёл билет !')
  end

  def ticket_remind(ticket)
    @ticket = ticket
    mail(to: ticket.user.email, subject: 'Дворников - Квестов. Скоро твой квест ! Не пропусти !')
  end

end