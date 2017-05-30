
module RecipesHelper


	# Print an Html label with picture and title of Recipe's type
	#
	# @param recipe [Recipe] as recipe to print
	# @return [String] as Html content
	# @return [nil] if it's not possible to create Html content
	def recipe_label_type recipe
		if recipe.rtype
			image_tag = image_tag "type_of_food/%s.svg" % recipe.rtype, class: "recipe-label"
			link_to image_tag + recipe.rtype , recipes_path( :type => recipe.rtype )  
		end
	end


	# Print an Html label with picture and title of Recipe's season
	#
	# @param recipe [Recipe] as recipe to print
	# @return [String] as Html content
	# @return [nil] if it's not possible to create Html content
	def recipe_label_season recipe
		if recipe.rtype
			image_tag = image_tag "seasons/%s.svg" % recipe.season, class: "recipe-label"
			link_to  image_tag + recipe.season , recipes_path( :season => recipe.season ) 
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
			image_tag = image_tag "time/#{time_name}.svg", class: "recipe-label"
			"#{image_tag} #{time}".html_safe
		else
			nil
		end
	end

end