require 'test_helper'

class PricePresetsControllerTest < ActionController::TestCase
  setup do
    @price_preset = price_presets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:price_presets)
  end

  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "should create price_preset" do
    assert_difference('PricePreset.count') do
      post :create, price_preset: { daytype_id: @price_preset.daytype_id, dt0: @price_preset.dt0, dt1: @price_preset.dt1, price: @price_preset.price, quest_item_id: @price_preset.quest_item_id }
    end

    assert_redirected_to price_preset_path(assigns(:price_preset))
  end

  test "should show price_preset" do
    get :show, id: @price_preset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @price_preset
    assert_response :success
  end

  test "should update price_preset" do
    patch :update, id: @price_preset, price_preset: { daytype_id: @price_preset.daytype_id, dt0: @price_preset.dt0, dt1: @price_preset.dt1, price: @price_preset.price, quest_item_id: @price_preset.quest_item_id }
    assert_redirected_to price_preset_path(assigns(:price_preset))
  end

  test "should destroy price_preset" do
    assert_difference('PricePreset.count', -1) do
      delete :destroy, id: @price_preset
    end

    assert_redirected_to price_presets_path
  end
end
