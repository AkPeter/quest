require 'test_helper'

class SmsControllerTest < ActionController::TestCase
  test "should get send" do
    get :send
    assert_response :success
  end

  test "should get status_upd" do
    get :status_upd
    assert_response :success
  end

end
