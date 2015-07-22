class Admin::PicturesofwinnersController < AdminController
  layout 'administration'

  before_action :set_picturesofwinner, only: [:show, :edit, :update, :destroy]

  # GET /admin/picturesofwinners
  # GET /admin/picturesofwinners.json
  def index
    @picturesofwinners = Picturesofwinner.all
  end

  # GET /admin/picturesofwinners/new
  def new
    @picturesofwinner = Picturesofwinner.new
  end

  # GET /admin/picturesofwinners/1/edit
  def edit
  end

  # POST /admin/picturesofwinners
  # POST /admin/picturesofwinners.json
  def create
    @picturesofwinner = Picturesofwinner.new(picturesofwinner_params)

    respond_to do |format|
      if @picturesofwinner.save
        format.html { redirect_to admin_picturesofwinners_url, notice: 'Всё норм' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @picturesofwinner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/picturesofwinners/1
  # PATCH/PUT /admin/picturesofwinners/1.json
  def update
    respond_to do |format|
      if @picturesofwinner.update(picturesofwinner_params)
        format.html { redirect_to admin_picturesofwinners_url, notice: 'Всё норм' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @picturesofwinner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/picturesofwinners/1
  # DELETE /admin/picturesofwinners/1.json
  def destroy
    @picturesofwinner.destroy
    respond_to do |format|
      format.html { redirect_to admin_picturesofwinners_url, notice: 'Всё норм' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picturesofwinner
      @picturesofwinner = Picturesofwinner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picturesofwinner_params
      params.require(:picturesofwinner).permit(:quest_item_id, :goaldate, :besttime, :description, :photourl)
    end
end