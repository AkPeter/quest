require 'test_helper'

class Admin::PicturesofwinnersControllerTest < ActionController::TestCase
  setup do
    @admin_picturesofwinner = admin_picturesofwinners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_picturesofwinners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_picturesofwinner" do
    assert_difference('Admin::Picturesofwinner.count') do
      post :create, admin_picturesofwinner: { date: @admin_picturesofwinner.date, gallerywinners: @admin_picturesofwinner.gallerywinners, goaltime: @admin_picturesofwinner.goaltime, photourl: @admin_picturesofwinner.photourl }
    end

    assert_redirected_to admin_picturesofwinner_path(assigns(:admin_picturesofwinner))
  end

  test "should show admin_picturesofwinner" do
    get :show, id: @admin_picturesofwinner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_picturesofwinner
    assert_response :success
  end

  test "should update admin_picturesofwinner" do
    patch :update, id: @admin_picturesofwinner, admin_picturesofwinner: { date: @admin_picturesofwinner.date, gallerywinners: @admin_picturesofwinner.gallerywinners, goaltime: @admin_picturesofwinner.goaltime, photourl: @admin_picturesofwinner.photourl }
    assert_redirected_to admin_picturesofwinner_path(assigns(:admin_picturesofwinner))
  end

  test "should destroy admin_picturesofwinner" do
    assert_difference('Admin::Picturesofwinner.count', -1) do
      delete :destroy, id: @admin_picturesofwinner
    end

    assert_redirected_to admin_picturesofwinners_path
  end
end
