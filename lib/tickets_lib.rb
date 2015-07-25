module TicketsLib

  def reserveTicket(tid)

    if current_user
      # сначала разрезервирование билета который вероятно уже зарезервирован на этого пользователя, ведь мог выйти из сессии а потом зайти
      tickets = Ticket.where('ticket_status_id=? and user_id=?', 2, session[:uid])
      if tickets.any?
        unless tickets.first.update(ticket_status_id: 1, user_id: nil)
          'root'
        end
      end

      session[:tid] = tid

      # резервирование билета который выбрал
      ticket = Ticket.find(tid)
      if ticket.update(ticket_status_id: 2, user_id: session[:uid], reserve_start_time: DateTime.now)
        UserMailer.ticket_reserved(ticket).deliver_now
        # снаряжаем фоновую задачу правильным образом !
        TicketUnreserveJob.set(wait_until: DateTime.now + RobokassaController::RESERVE_TIME).perform_later(tid, session[:uid])
        'payment'
      else
        'root'
      end
    else
      session[:tid] = tid
      'signin'
    end
  end

end