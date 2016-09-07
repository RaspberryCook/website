require 'test_helper'
require 'sessions_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not create recipe because no one is connected" do
    assert_no_difference('Recipe.count') do
      post :create, recipe: { name: "hello" }
    end
  end



  test "should be redirected to signup path when non-logged user want create a recipe" do
    get :create
    assert_redirected_to signup_path
  end

  # test "should show recipe" do
  #   get :show, id: @recipe
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: @recipe
  #   assert_response :success
  # end

  # test "should update recipe" do
  #   patch :update, id: @recipe, recipe: {  }
  #   assert_redirected_to recipe_path(assigns(:recipe))
  # end

  # test "should destroy recipe" do
  #   assert_difference('recipe.count', -1) do
  #     delete :destroy, id: @recipe
  #   end

  #   assert_redirected_to recipes_path
  # end
end
