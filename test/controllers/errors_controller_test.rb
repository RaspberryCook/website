require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase


  test "should not get not_found" do
    get :not_found
    assert_response 404
  end

  test "should not get internal_server_error" do
    get :internal_server_error
    assert_response 500
  end

end