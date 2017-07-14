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


namespace "pictures"  do
	desc "regenerate recipe pictures size"
	task :resize => :environment do
		Recipe.all.select{|r| r.has_image? }.each do |recipe|
			 begin
				recipe.image.recreate_versions!
				puts "#{recipe.id} - #{recipe.name} resized!"
			rescue => e
				puts  "ERROR: #{recipe.id} - #{recipe.name} -> #{e.to_s}"
			end
		end
	end
end

namespace "craw" do

	desc "crawl marmiton"
	task :marmiton => :environment do
	end

end