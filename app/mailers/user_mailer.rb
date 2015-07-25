class UserMailer < ApplicationMailer
  include SmsLib

  def admins_mail
    User.where(admin:true).pluck(:email)
  end
  helper_method :admins_mail

  def new_bee(user, password)
    @username = user.name
    @signin  = ApplicationController::SignInURL
    @password = password

    sms_new_bee user, password if user.phone

    mail(to: user.email, subject: "С подключением на #{ApplicationController::Domain} !")
  end

  def password_reset(user, new_password)
    @username = user.name
    @signin  = ApplicationController::SignInURL
    @new_password = user, new_password

    sms_password_reset user, new_password if user.phone

    mail(to: user.email, subject: "Новый пароль для входа на #{ApplicationController::Domain}")
  end

  def ticket_reserved(ticket)
    @signin  = ApplicationController::SignInURL
    @ticket = ticket
    @reserve_time = Time.at(RobokassaController::RESERVE_TIME).strftime("%M")

    sms_ticket_reserved ticket if ticket.user.phone

    mail(to: ticket.user.email, subject: "Резерв билета.")
  end

  def ticket_purchased(ticket, anal)# анал - это когда покупают за анал .)
    pay_way = anal ? 'оплатит НАЛИЧНЫМИ' : 'оплатил ROBOKASSA'

    @ticket = ticket

    sms_ticket_purchased ticket if ticket.user.phone

    mail(to: ticket.user.email, subject: "Ты приобрёл билет")
    mail(to: admins_mail, subject: "#{ticket.user.name} приобрёл билет. #{pay_way}", :template_name => 'ticket_purchased2admin')
  end

  def ticket_remind(ticket)
    @ticket = ticket

    sms_ticket_remind ticket if ticket.user.phone

    mail(to: ticket.user.email, subject: "Скоро твой квест ! Не пропусти !")
  end

end