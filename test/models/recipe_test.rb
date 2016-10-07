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

  # PICTURE AREA

  test "recipe should return default picture as picture" do
    recipe = recipes(:two)
    assert_equal '/assets/images/default.png', recipe.true_image_url
  end

  test "recipe should return default picture as thumb" do
    recipe = recipes(:two)
    assert_equal '/assets/images/default.png', recipe.true_thumb_image_url
  end

  test "if forked recipe have not picture, it should return parent's picture" do
    recipe = recipes(:two)
    # set a picture & fork the recipe
    picture_url = File.open(Rails.root.join("public/assets/images/raspberry_cook.svg"))
    recipe.image = picture_url
    forked_recipe = recipe.fork 2
    # compare only the filename
    assert_equal forked_recipe.true_image_url.split('/').last, recipe.image.url.split('/').last
  end


  test "sould return the good average for the rate" do
    pasta = recipes(:pasta)
    assert_equal 3, pasta.rate
  end

end
