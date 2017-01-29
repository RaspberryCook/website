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
