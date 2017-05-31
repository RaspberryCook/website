
module RecipesHelper


	# Print an Html label with picture and title of Recipe's type
	#
	# @param recipe [Recipe] as recipe to print
	# @return [String] as Html content
	# @return [nil] if it's not possible to create Html content
	def recipe_label_type recipe
		if recipe.rtype
			html_image = image_tag "type_of_food/%s.svg" % recipe.rtype, class: "recipe-label", alt: 'Type de plat', size: '40'
			link_to html_image + recipe.rtype , recipes_path( :type => recipe.rtype )
		end
	end


	# Print an Html label with picture and title of Recipe's season
	#
	# @param recipe [Recipe] as recipe to print
	# @return [String] as Html content
	# @return [nil] if it's not possible to create Html content
	def recipe_label_season recipe
		if recipe.rtype
			html_image = image_tag "seasons/%s.svg" % recipe.season, class: "recipe-label", alt: 'Icon de la saison', size: '40'
			link_to  html_image + recipe.season , recipes_path( :season => recipe.season )
		else
			nil
		end
	end


	# Print an Html label with picture and title of Recipe's season
	#
	# @param recipe [Recipe] as recipe to print
	# @param time_name [String] as Recipe's time to print (can be rest, cook, etc..)
	# @return [String] as Html content
	# @return [nil] if it's not possible to create Html content
	def recipe_label_time recipe, time_name
		time_of_recipe = recipe.public_send time_name

		if time_of_recipe
			time = "<time>%s\"</time>" % time_of_recipe
			html_image = image_tag "time/#{time_name}.svg", class: "recipe-label"
			"#{html_image} #{time}".html_safe
		else
			nil
		end
	end

end
