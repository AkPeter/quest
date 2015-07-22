class TicketsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  GenerationPeriod = 2.weeks

  include TicketsLib

  def reserve
    result = reserveTicket params[:tid]
    render text: result
  end

end