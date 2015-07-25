class TicketsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  GenerationPeriod = 2.weeks
  UserRemindBefore = 1.day

  include TicketsLib

  def reserve
    result = reserveTicket params[:tid]
    render text: result
  end

  def ticket_cash_purchase
    ticket = current_ticket

    if ticket
        if ticket.update(ticket_status_id: 3)
          UserMailer.ticket_purchased(ticket, true).deliver_now

          # снаряжаем фоновую задачу правильным образом ! ну и рассылка будет если ещё не поздно рассылать )
          time2remind = ticket.dt.to_datetime - TicketsController::UserRemindBefore
          TicketUserRemindJob.set(wait_until: time2remind).perform_later(ticket.id, current_user.id) if DateTime.now < time2remind

          flash[:notice] = 'Билет выкуплен, с Вами свяжуться по телефону'
          redirect_to action: :ticket_cash_purchase_complete, id: ticket
        else
          redirect_to payment_url, notice: 'Проблемы со связью, попробуйте оплатить ещё раз'
        end
    else
      redirect_to payment_url
    end
  end

  def ticket_cash_purchase_complete
    tickets = Ticket.where('id=?', params[:id].to_i)
    if tickets.any?
      @ticket = tickets.first
    end
  end

end