require 'test_helper'
require "authlogic/test_case"
include Authlogic::TestCase

class UserSessionTest < ActiveSupport::TestCase

  setup :activate_authlogic

  test "should accept connection" do
    ben = users(:ben)
    assert UserSession.create(ben)
  end

  test "should signup" do 
    ben = users(:ben)
    assert_nil controller.session["user_credentials"]
    assert UserSession.create(ben)
    assert_equal controller.session["user_credentials"], ben.persistence_token
  end

end