class UserMailer < ApplicationMailer

  def new_bee(user, password)
    @username = user.name
    @signin  = ApplicationController::SignInURL
    @password = password

    SmsController.new_bee user, password if user.phone

    mail(to: user.email, subject: "С подключением на #{ApplicationController::Domain} !")
  end

  def password_reset(user, new_password)
    @username = user.name
    @signin  = ApplicationController::SignInURL
    @new_password = user, new_password

    SmsController.password_reset new_password if user.phone

    mail(to: user.email, subject: "Новый пароль для входа на #{ApplicationController::Domain}")
  end

  def ticket_reserved(ticket)
    @signin  = ApplicationController::SignInURL
    @ticket = ticket
    @reserve_time = RobokassaController::RESERVE_TIME

    SmsController.ticket_reserved ticket if ticket.user.phone

    mail(to: ticket.user.email, subject: "Резерв билета.")
  end

  def ticket_purchased(ticket)
    @ticket = ticket

    SmsController.ticket_purchased ticket if ticket.user.phone

    mail(to: ticket.user.email, subject: "Ты приобрёл билет !")
  end

  def ticket_remind(ticket)
    @ticket = ticket

    SmsController.ticket_remind ticket if ticket.user.phone

    mail(to: ticket.user.email, subject: "Скоро твой квест ! Не пропусти !")
  end

end