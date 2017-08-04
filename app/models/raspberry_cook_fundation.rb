module RaspberryCookFundation

  # Create JSONLD of Raspberry Cook
  #
  # @param type [String] schema.ord type of jsonld can be `WebSite` or `Organization`
  # @return [Boolean] if picture exists
  def self.to_jsonld type
    if ['WebSite', 'Organization'].include? type
      {
        "@context": "http://schema.org",
        "@type": type,
        name: "Raspberry Cook",
        url: "http://raspberry-cook.fr",
        author: author,
        funder: author,
        sameAs: [
          "https://www.facebook.com/raspberrycook",
          "https://github.com/RaspberryCook",
          "https://www.instagram.com/raspberry_cook",
        ],
        contactPoint: {
          email: 'a.rousseau@protonmail.com'
        }
      }
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
      url: 'http://rousseau-alexandre.fr',
      contactPoint: {
        email: 'a.rousseau@protonmail.com'
      },
      sameAs: [
        'https://www.linkedin.com/in/alexandre-rousseau-a55a9464/'
      ]
    }
  end
end
