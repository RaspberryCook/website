require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  test "should found one recipe" do
    recipes = Recipe.search 'to_search' , 'to_search' , nil, nil, 1
    assert_equal 0, recipes.count
  end

  test "should not found one recipe" do
    recipes = Recipe.search 'not_to_search' , 'to_search' , nil, nil, 1
    assert_equal 0, recipes.count
  end

  test "should fork the recipe" do
    # create a recipe & fork it
    recipe = recipes(:two)
    forked_recipe = recipe.fork 99
    # check if recipe was added
    assert_difference('Recipe.count') do
      forked_recipe.save
    end
    # check if recipe can be find by user id
    recipe_searched = Recipe.find_by user_id: 99
    assert_equal recipe_searched , forked_recipe
  end

  test "forked recipe should be respond as forked" do
    recipe = recipes(:two)
    forked_recipe = recipe.fork 2
    assert forked_recipe.forked?
    assert_equal recipe, forked_recipe.root_recipe
  end


end
