# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

RaspberryCook::Application.load_tasks

namespace "friendlyid" do
	desc "Generate slugs"
	task :slug  => :environment do
		Recipe.all.each do |recipe|
			if recipe.save
				puts "[x] #{recipe.name} saved. Slug are now: #{recipe.slug}"
			else
				puts "[ ] #{recipe.name}not  saved"
			end
		end
	end
end

namespace "migrations" do

	# I had several issues with recipe time
	# * sometimes I saved minutes as seconds
	# * sometimes I saved 1:00:00 for zero time
	# this script will attempts to convert these data to minutes
	desc "Convert times to integer"
	task :preptimes  => :environment do

		Recipe.all.each do |recipe|
			%w(cooking cooling baking rest).each do |time_type|
				# for each recipe, we check if old time (begining by `t_` ) exists.
				# if yes , we try to build an intger from it and we update the recipe
				if time = recipe.send("t_#{time_type}")
					time_estimated = time.sec + time.min
					recipe.send("#{time_type}=" , time_estimated)
					recipe.save
				end
			end
		end
	end
end