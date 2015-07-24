class Admin::ResponsesController < AdminController
  before_action :set_response, only: [:destroy]

  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Отзыв удалён' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_response
    @response = Response.find(params[:id])
  end
end
