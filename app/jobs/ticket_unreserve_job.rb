class TicketUnreserveJob < ActiveJob::Base
  queue_as :tickets_unreserve

  def perform(tid, uid)
  # разрезервирование такого-то билета зарезервированного 17 минут назад на такого-то пользователя к такой-то матери !
    tickets = Ticket.where('id=? and user_id=? and ticket_status_id=?', tid, uid, 2)
    if tickets.any?
      tickets.first.update(ticket_status_id: 1, user_id: nil)
    end
  end

end