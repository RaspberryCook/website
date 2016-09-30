require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get signin" do
    get :new
    assert_response :success
  end


end