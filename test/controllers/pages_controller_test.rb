require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test "should get credits" do
    get :credits
    assert_response :success
  end


  test "should get infos" do
    get :infos
    assert_response :success
  end


  test "should get home" do
    get :home
    assert_response :success
  end


end
