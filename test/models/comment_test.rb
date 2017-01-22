require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @me = users(:me)
    @my_girlfriend = users(:my_girlfriend)
    @my_recipe = recipes(:my_recipe)
    @girlfirend_recipe = recipes(:girlfirend_recipe)
  end


  # add a new comment on mine recipe and check if unread comment count grow
  test "should produce unread comments" do
    assert_difference 'Comment.unread_by(@me).count', 1 do
      Comment.create title: 'good', content: 'not so bad', user_id: @my_girlfriend.id, recipe_id: @my_recipe.id
    end
  end



  # add a new comment on girlfriend recipe and check if unread comment stay same because I'm the author
  test "should not produce unread comment because it's not my recipe" do
    assert_no_difference 'Comment.unread_by(@me).count' do
      Comment.create title: 'good', content: 'not so bad', user_id: @my_girlfriend.id, recipe_id: @girlfirend_recipe.id
    end
  end


end