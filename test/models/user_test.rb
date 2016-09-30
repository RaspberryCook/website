require 'test_helper'
require "authlogic/test_case"
include Authlogic::TestCase

class UserTest < ActiveSupport::TestCase

  setup :activate_authlogic

  test "should return the comment posted" do
    user = users(:one)
    comment = comments(:one)
    user_comment = user.comment_on_recipe comment.recipe_id
    assert_equal user_comment, comment
    assert_not_equal user_comment, Comment.new
  end


  test "should return the correct rank" do
    user = users(:one)
    assert_equal 21, user.rank
  end

  test "should have an encrypted password" do
    password = 'oneTest28'
    user = User.create email: 'test@test.fr', username: 'test', firstname: 'test', password: password, password_confirmation: password
    assert user.save
    assert_not_nil user.crypted_password
    assert_equal Authlogic::CryptoProviders::Sha512.encrypt(password) , user.crypted_password
  end

end
