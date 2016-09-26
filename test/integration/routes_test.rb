require 'test_helper'

class RoutesTest < ActionController::TestCase
  test "route test" do

    assert_routing "/recipes/1", { controller: "recipes", action: "show", id: "1" }
    assert_routing "/recipes/fork/1", { controller: "recipes", action: "fork", id: "1" }
    assert_routing "/recipes/save/1", { controller: "recipes", action: "save", id: "1" }
    assert_routing "/recipes/search", { controller: "recipes", action: "search" }

    assert_routing "/signout", { controller: "sessions", action: "destroy" }

    assert_routing "/home", { controller: "pages", action: "home" }
    assert_routing "/infos", { controller: "pages", action: "infos" }
    assert_routing "/credits", { controller: "pages", action: "credits" }
  
  end
end