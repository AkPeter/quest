class Admin::ManageTicketsController < AdminController
  layout 'administration'

  def price
    redirect_to :back unless Ticket.any?
    @quest_item = QuestItem.all
    @statuses = TicketStatus.all
  end

  def price_update
    Ticket.where('quest_item_id=? AND dt BETWEEN ? AND ?', params[:quest_item], (parse_datetime_params params[:start]), (parse_datetime_params params[:end])).find_each do |ticket|
      ticket.update(price: ticket.price.to_i + params[:priceup].to_i, ticket_status_id: params[:status])
    end

    redirect_to :back
  end
end