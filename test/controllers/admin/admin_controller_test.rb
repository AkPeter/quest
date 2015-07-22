require 'test_helper'

class Admin::AdminControllerTest < ActionController::TestCase
  test "should get require_admin" do
    get :require_admin
    assert_response :success
  end

end
