require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @me = users(:me)
    @my_girlfriend = users(:my_girlfriend)
    @my_recipe = recipes(:my_recipe)
    @girlfirend_recipe = recipes(:girlfirend_recipe)
  end



  test "should return the comment posted" do
    comment = comments(:one)
    user_comment = @me.comment_on_recipe comment.recipe_id
    assert_equal user_comment, comment
    assert_not_equal user_comment, Comment.new
  end



  test "should return the correct rank" do
    assert_equal 21, @me.rank
  end



  test "should have an encrypted password" do
    password = 'oneTest28'
    user = User.create email: 'test@test.fr', username: 'test', firstname: 'test', password: password, password_confirmation: password
    assert user.save
    assert_not_nil user.crypted_password
  end


end