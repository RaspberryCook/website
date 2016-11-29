require 'test_helper'
require "authlogic/test_case"

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:me)
  end

  setup :activate_authlogic

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get signup" do
    get :new
    assert_response :success
  end


  test "should create a new user" do
    password = 'oneTest28'

    assert_difference('User.count', 1) do
      post :create, user: { email: 'test@test.fr', username: 'test', firstname: 'test', password: password, password_confirmation: password}
    end
  end

  test "should not create an user because of wrong email" do
    password = 'oneTest28'
    assert_no_difference('User.count' ) do
      post :create, user: { email: 'a_wrong_email.fr', username: 'test', firstname: 'test', password: password, password_confirmation: password}
    end
    assert_response 200
  end

  test "should not create an user because of wrong password_confirmation" do
    password = 'oneTest28'
    assert_no_difference('User.count' ) do
      post :create, user: { email: 'test@test.fr', username: 'test', firstname: 'test', password: password, password_confirmation: "wrong_password_confirmation"}
    end
    assert_response 200
  end


  test "should show user" do
    get :show, id: @user
    assert_response :success
  end


  test "should access to edit user" do
    #try to edit as me
    UserSession.create(users(:me))
    get :edit, id: @user
    assert_response :success
  end


  test "should not access to edit user because it's not him" do
    #try to edit as me
    UserSession.create(users(:ben))
    get :edit, id: @user
    assert_redirected_to  '/' 
  end


  test "should update user" do
    password = 'oneTest28'
    UserSession.create(users(:me))
    patch :update, id: @user, user: { firstname: 'new firstname',password: password, password_confirmation: password}
    assert_redirected_to user_path(@user)
  end


  test "should not update user because current_user is not the author" do
    password = 'oneTest28'
    UserSession.create(users(:ben))
    patch :update, id: @user, user: { firstname: 'new firstname',password: password, password_confirmation: password}
    assert_redirected_to '/'
  end


  # test "should destroy recipe" do
  #   UserSession.create(users(:me))
  #   assert_difference('Recipe.count', -1) do
  #     delete :destroy, id: @recipe
  #   end
  # end


  # test "should not destroy recipe because current_user is not the author" do
  #   UserSession.create(users(:ben))
  #   assert_no_difference('Recipe.count') do
  #     delete :destroy, id: @recipe
  #   end
  # end

end