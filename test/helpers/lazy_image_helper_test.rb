require 'test_helper'
require '/home/arousseau/dev/ruby/raspberry_cook/app/helpers/lazy_image_helper.rb'

class RecipeHelperTest < ActionView::TestCase

  include LazyImageHelper

  test "should create image tag with lazy loader" do
    # simple use
    assert_equal lazy_image_tag('default.svg'),
      '<img data-src="http://test.host/images/default.svg" class="lazyload" alt="Default" />'

    assert_equal lazy_image_tag('default.svg', class: 'test'),
      '<img data-src="http://test.host/images/default.svg" class="test lazyload" alt="Default" />'

    assert_equal lazy_image_tag('default.svg', class: 'test', alt: 'hello'),
      '<img data-src="http://test.host/images/default.svg" class="test lazyload" alt="hello" />'
  end


end
