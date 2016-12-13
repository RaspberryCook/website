# Global helpers for to use in views
module ApplicationHelper

  # Generate an image source from an email
  # @todo move this method on User class
  #
  # @param email [String] as email adress to fetch on gravatar
  # @param size [Integer] as size for the image
  # @return [String] as image url
	def gravatar_url email, size
		gravatar = Digest::MD5::hexdigest(email).downcase
		url = "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
		return url
	end

end
