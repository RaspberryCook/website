require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should return the comment posted" do
    user = users(:me)
    comment = comments(:one)
    user_comment = user.comment_on_recipe comment.recipe_id
    assert_equal user_comment, comment
    assert_not_equal user_comment, Comment.new
  end


  test "should return the correct rank" do
    user = users(:me)
    assert_equal 21, user.rank
  end

  test "should have an encrypted password" do
    password = 'oneTest28'
    user = User.create email: 'test@test.fr', username: 'test', firstname: 'test', password: password, password_confirmation: password
    assert user.save
    assert_not_nil user.crypted_password
  end

  # add a new comment on mine recipe and check if unread comment count grow
  test "should get unread comments" do
    me = users(:me)
    comments_count =  me.unread_comments{|com| com}.count
    # my girlfriend create a comment on my recipe 
    Comment.create title: 'good', content: 'not so bad', user_id: 2, recipe_id: 1
    assert_equal comments_count+1, me.unread_comments{|com| com}.count
  end

end
