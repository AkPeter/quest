class Admin::MainController < AdminController
  layout 'administration'

  def index
    @tickets = Ticket.where.not(user_id: nil).order(ticket_status_id: :desc, updated_at: :desc)
    render :template => 'admin/main/index', locals: {tickets_count: @tickets.any?}
  end
end
