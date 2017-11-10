module LazyImageHelper

  # Create image tag with lazyloader
  # @see https://appelsiini.net/projects/lazyload/
  def lazy_image_tag source, options = {}
    options[:data] = {src: {}} unless options[:data]
    options[:data][:src] = image_path(source)

    # add lazy load class
    if options[:class].nil?
      options[:class] = 'lazyload'
    else
      options[:class] += ' lazyload'
    end
    image_tag 'default.svg', options
  end

end
