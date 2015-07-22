require 'test_helper'

class QuestItemsControllerTest < ActionController::TestCase
  setup do
    @quest_item = quest_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quest_items)
  end

  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "should create quest_item" do
    assert_difference('QuestItem.count') do
      post :create, quest_item: { name: @quest_item.name, quest_status_id: @quest_item.quest_status_id }
    end

    assert_redirected_to quest_item_path(assigns(:quest_item))
  end

  test "should show quest_item" do
    get :show, id: @quest_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quest_item
    assert_response :success
  end

  test "should update quest_item" do
    patch :update, id: @quest_item, quest_item: { name: @quest_item.name, quest_status_id: @quest_item.quest_status_id }
    assert_redirected_to quest_item_path(assigns(:quest_item))
  end

  test "should destroy quest_item" do
    assert_difference('QuestItem.count', -1) do
      delete :destroy, id: @quest_item
    end

    assert_redirected_to quest_items_path
  end
end
