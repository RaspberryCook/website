require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get signin" do
    get :new
    assert_response :success
  end



  test "connection should be refused" do
    user = users(:one)
    post :new , params: { email: user.email, password: 'invalid' }
    assert_response :success
  end

end