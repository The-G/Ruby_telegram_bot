require 'test_helper'

class MsgControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get send" do
    get :send
    assert_response :success
  end

end
