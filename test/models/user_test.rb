require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should return the comment posted" do
    user = users(:one)
    comment = comments(:one)
    user_comment = user.comment_on_recipe comment.recipe_id
    assert_equal user_comment, comment
    assert_not_equal user_comment, Comment.new
  end


  test "should return the correct rank" do
    user = users(:one)
    assert_equal 11, user.rank
  end

end
