require 'test_helper'
require "authlogic/test_case"

class PagesControllerTest < ActionController::TestCase

  setup :activate_authlogic

  test "should get credits" do
    get :credits
    assert_response :success
  end


  test "should get home" do
    get :home
    assert_response :success
  end


  test "should get feeds" do
    UserSession.create(users(:my_girlfriend))
    get :feeds
    assert_response :success
  end


  test "should not get feeds because no one is connected" do
    get :feeds
    assert_redirected_to signup_path
  end

  test "should get fridge" do
    get :fridge
    assert_response :success
  end

  test "should post fridge" do
    post :fridge, ingredients: "az_az"
    assert_response :success
  end


end
