require 'test_helper'
require "authlogic/test_case"
include Authlogic::TestCase

class UserSessionTest < ActiveSupport::TestCase

  setup :activate_authlogic

  test "should accept connection" do
    ben = users(:ben)
    assert UserSession.create(ben)
  end

end