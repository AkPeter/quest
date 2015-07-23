class ResponsesController < ApplicationController
  before_action :set_response, only: [:update, :destroy]

  def index
    @responses = Response.all.where('quest_item_id=?', current_quest)
  end

  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to root_url, notice: 'Отзыв оставлен' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to root_url, notice: 'Отзыв отредактирован' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def response_params
    params.require(:response).permit(:quest_item_id, :user_id, :content)
  end
end
