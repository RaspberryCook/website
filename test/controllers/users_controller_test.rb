require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @users = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get signup" do
    get :new
    assert_response :success
  end

end
