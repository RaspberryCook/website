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

namespace "crawl" do


  def find_or_create_user email
    # create username with email hostname
    username = email.split('@')[1]

    return User.find_by( email: email) || User.create(username: username, email: email, firstname: username, lastname: username,
                                                      password: Rails.application.secrets.foreign_password,
                                                      password_confirmation: Rails.application.secrets.foreign_password)
  end


  def import_recipe page, user
    begin
      # import from the url
      recipe = Recipe.import page.url.to_s, user.id
      puts "[x] #{recipe.name} importé"

    rescue ArgumentError
      puts "[ ] Cette URL n'est pas suportée par Raspberry Cook :("

    rescue Exception => e
      puts "[ ] #{e.to_s}"
    end
  end



  desc "crawl marmiton"
  task :marmiton => :environment do
    # first, we fetch or create marmiton user
    user = find_or_create_user 'chef@marmiton.org'

    Anemone.crawl('http://www.marmiton.org/') do |anemone|
      anemone.on_pages_like(/.*\/recettes\/.*/) do |page|
        import_recipe page, user
      end
    end
  end


  desc "crawl 750g"
  task :g750 => :environment do
    # first, we fetch or create 750g user
    user = find_or_create_user 'accueil@750g.com'

    Anemone.crawl('http://www.750g.com') do |anemone|
      anemone.on_every_page do |page|
        import_recipe page, user
      end
    end
  end


  desc "crawl cuisineaz"
  task :cuisineaz => :environment do
    # first, we fetch or create 750g user
    user = find_or_create_user 'recettes@cuisineaz.com'

    Anemone.crawl('http://www.cuisineaz.com/') do |anemone|
      anemone.on_pages_like(/.*\/recettes\/.*/) do |page|
        import_recipe page, user
      end
    end
  end

end
