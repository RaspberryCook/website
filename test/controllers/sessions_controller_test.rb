require 'test_helper'
require "authlogic/test_case"

class SessionsControllerTest < ActionController::TestCase

  setup :activate_authlogic

  test "should get signin" do
    get :new
    assert_response :success
  end


  test "should signup and redirect to user" do
    ben = users(:ben)
    post :create, sessions: { username: 'whatever', password: 'whatever' } 
    assert_redirected_to(  controller: "users", action: "show", id: ben.id ) 
  end


  test "should not signup" do
    ben = users(:ben)
    post :create, sessions: { username: 'whatever', password: 'invalid' } 
    assert_response :success
  end

end