class Admin::PricePresetsController < AdminController
  layout 'administration'

  before_action :set_price_preset, only: [:show, :edit, :update, :destroy]

  # GET /price_presets
  # GET /price_presets.json
  def index
    @price_presets = PricePreset.all.order(quest_item_id: :asc, daytype_id: :asc, t0: :asc)
  end

  # GET /price_presets/1
  # GET /price_presets/1.json
  def show
  end

  # GET /price_presets/signin
  def new
    @price_preset = PricePreset.new
  end

  # GET /price_presets/1/edit
  def edit
  end

  # POST /price_presets
  # POST /price_presets.json
  def create
    @price_preset = PricePreset.new(price_preset_params)

    respond_to do |format|
      if @price_preset.save
        format.html { redirect_to [:admin, @price_preset] }
        format.json { render :show, status: :created, location: @price_preset }
      else
        format.html { render :new }
        format.json { render json: @price_preset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_presets/1
  # PATCH/PUT /price_presets/1.json
  def update
    respond_to do |format|
      if @price_preset.update(price_preset_params)
        format.html { redirect_to admin_price_presets_url }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @price_preset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_presets/1
  # DELETE /price_presets/1.json
  def destroy
    unless @price_preset.destroy
      flash[:notice] = "Последний preset удалять нельзя, его следует редактировать"
    end
    respond_to do |format|
      format.html { redirect_to admin_price_presets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_preset
      @price_preset = PricePreset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_preset_params
      params.require(:price_preset).permit(:quest_item_id, :daytype_id, :t0, :t1, :price)
    end
end
