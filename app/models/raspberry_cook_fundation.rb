module RaspberryCookFundation

  RASPERRY_COOK_URL = 'http://raspberry-cook.fr'

  # Create JSONLD of Raspberry Cook
  #
  # @param type [String] schema.ord type of jsonld can be `WebSite` or `Organization`
  # @return [Boolean] if picture exists
  def self.to_jsonld type
    if ['WebSite', 'Organization'].include? type
      jsonld = {
        "@context": "http://schema.org",
        "@type": type,
        funder: author,
        sameAs: [
          "https://www.facebook.com/raspberrycook",
          "https://github.com/RaspberryCook",
          "https://www.instagram.com/raspberry_cook",
        ],
        contactPoint: contact_point,
        url: RASPERRY_COOK_URL
      }

      jsonld['author'] = author if type == 'WebSite'

      return jsonld
    else
      raise ArgumentError.new "type '#{type}' not recognized"
    end
  end

  private

  def self.author
    {
      "@context" => "http://schema.org/",
      "@type": "Person",
      givenName: 'Alexandre',
      familyName: 'Rousseau',
      contactPoint: contact_point,
      sameAs: [
        'https://www.linkedin.com/in/alexandre-rousseau-a55a9464/'
      ],
      url: Rails.application.routes.url_helpers.user_url(1)
    }
  end

  def self.contact_point
    {
      email: 'a.rousseau@protonmail.com',
      contactType: 'customer service',
      url: 'http://rousseau-alexandre.fr'
    }
  end
end
