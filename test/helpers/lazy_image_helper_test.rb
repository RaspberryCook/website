require 'test_helper'
require '/home/arousseau/dev/ruby/raspberry_cook/app/helpers/lazy_image_helper.rb'

class RecipeHelperTest < ActionView::TestCase

  include LazyImageHelper

  test "should create image tag with lazy loader" do
    # simple use
    assert_equal '<img data-src="/images/github.svg" class="lazyload" src="/images/default.svg" alt="github" />', lazy_image_tag('github.svg')

    assert_equal '<img data-src="/images/github.svg" class="test lazyload" src="/images/default.svg" alt="github" />', lazy_image_tag('github.svg', class: 'test')

    assert_equal '<img  data-src="/images/github.svg" class="test lazyload" src="/images/default.svg" alt="hello" />', lazy_image_tag('github.svg', class: 'test', alt: 'hello')
  end


end
