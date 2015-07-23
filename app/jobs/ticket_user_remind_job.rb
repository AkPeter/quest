class TicketUserRemindJob < ActiveJob::Base
  queue_as :tickets_user_remind

  def perform(tid, uid)
    # напоминание пользователю что пора уже на квест собираться
    users = User.where('id=?', uid)
    tickets = User.where('id=? and ticket_status_id=?', tid, 3)

    UserMailer.ticket_remind(tickets.first).deliver_now if users.any?&&tickets.any?
  end

end