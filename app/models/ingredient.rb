class Ingredient 

    require 'open-uri'
    require 'net/http'
    require 'json'



    public

		def self.find ( thing )
			@file = open "http://world.openfoodfacts.org/cgi/search.pl?search_terms=#{thing}&search_simple=1&action=process&json=1"
		    json_file = JSON.load(@file)
		    hash = JSON.parse(json_file.to_json)
		    hash['products']
		end


end
