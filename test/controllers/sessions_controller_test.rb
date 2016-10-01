require 'test_helper'
require "authlogic/test_case"

class SessionsControllerTest < ActionController::TestCase

  setup :activate_authlogic

  test "should get signin" do
    get :new
    assert_response :success
  end


  test "should signup" do 
    ben = users(:ben)
    assert_nil controller.session["user_credentials"]
    assert UserSession.create(ben)
    assert_equal controller.session["user_credentials"], ben.persistence_token
  end


end