require 'test_helper'
require "authlogic/test_case" # include at the top of test_helper.rb

class CommentsControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
    @my_comment = comments(:my_comment_about_pasta)
    @gf_comment = comments(:girlfriend_comment_about_pasta)
  end

  setup :activate_authlogic


  test "should create a comment" do
    UserSession.create(users(:ben))
    assert_difference('Comment.count', 1) do
      post :create, comment: { title: "good", content: 'not so bad recipe', recipe_id: 1 }
    end
  end

  test "should not create comment because no one is connected" do
    assert_no_difference('Comment.count') do
      post :create, comment: { title: "good", content: 'not so bad recipe', recipe_id: 1 }
    end
  end


  test "should update comment" do
    UserSession.create(users(:me))
    patch :update, id: @my_comment, comment: { title: "good", content: 'not so bad recipe'}
    assert_redirected_to recipe_path(@my_comment.recipe)
  end


  test "should not update comment because current_user is not the author" do
    UserSession.create(users(:my_girlfriend))
    patch :update, id: @my_comment, comment: { title: "good", content: 'not so bad recipe'}
    assert_redirected_to '/'
  end


  test "should destroy comment" do
    UserSession.create(users(:me))
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @my_comment
    end
  end


  test "should not destroy comment because current_user is not the author" do
    UserSession.create(users(:ben))
    assert_no_difference('Comment.count') do
      delete :destroy, id: @my_comment
    end
  end
  

end
