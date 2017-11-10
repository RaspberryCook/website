require 'test_helper'
require '/home/arousseau/dev/ruby/raspberry_cook/app/helpers/lazy_image_helper.rb'

class RecipeHelperTest < ActionView::TestCase

  include LazyImageHelper

  test "should create image tag with lazy loader" do
    # simple use
    assert_equal '<img data-src="http://test.host/images/github.svg" class="lazyload" src="http://test.host/images/default.svg" alt="Default" />', lazy_image_tag('github.svg')

    assert_equal '<img class="test lazyload" data-src="http://test.host/images/github.svg" src="http://test.host/images/default.svg" alt="Default" />', lazy_image_tag('github.svg', class: 'test')

    assert_equal '<img class="test lazyload" alt="hello" data-src="http://test.host/images/github.svg" src="http://test.host/images/default.svg" />', lazy_image_tag('github.svg', class: 'test', alt: 'hello')
  end


end
