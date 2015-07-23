class Admin::QuestItemsController < AdminController
  layout 'administration'

  before_action :set_quest_item, only: [:show, :edit, :update, :destroy]

  # GET /quest_items
  # GET /quest_items.json
  def index
    @quest_items = QuestItem.all
  end

  # GET /quest_items/1
  # GET /quest_items/1.json
  def show
  end

  # GET /quest_items/signin
  def new
    @quest_item = QuestItem.new
  end

  # GET /quest_items/1/edit
  def edit
  end

  # POST /quest_items
  # POST /quest_items.json
  def create
    @quest_item = QuestItem.new(quest_item_params)

    respond_to do |format|
      if @quest_item.save
        format.html { redirect_to admin_quest_items_url, notice: 'Всё норм' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @quest_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quest_items/1
  # PATCH/PUT /quest_items/1.json
  def update
    respond_to do |format|
      if @quest_item.update(quest_item_params)
        format.html { redirect_to admin_quest_items_url, notice: 'Всё норм' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @quest_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quest_items/1
  # DELETE /quest_items/1.json
  def destroy
    @quest_item.destroy
    respond_to do |format|
      format.html { redirect_to admin_quest_items_url, notice: 'Всё норм' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest_item
      @quest_item = QuestItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quest_item_params
      params.require(:quest_item).permit(:name, :session_length, :quest_status_id)
    end
end