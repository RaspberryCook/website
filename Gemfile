source 'https://rubygems.org'

gem 'rails', '4.0.13'# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'




#Database
gem 'sqlite3'# Use sqlite3 as the database for Active Record
gem 'mysql2' , '~> 0.3.18' #need to install libmysqlclient-dev

#for avatar
gem 'gravatar'

# Use SCSS & SASS for stylesheets
gem 'sass-rails', '~> 4.0.2'
gem 'compass'
gem 'compass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# to manage read/unread status of ActiveRecord objects - and it's fast.
gem 'unread'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'json'

#for use old version of rails for attributes
gem 'protected_attributes'

# for Autocomplete system
gem 'rails4-autocomplete'
gem 'rails-jquery-autocomplete'

gem 'will_paginate', '~> 3.0.6'#https://github.com/mislav/will_paginate


group :development do
	# Use Capistrano for deployment
	gem 'net-ssh' 
	gem 'capistrano',		require: false
	gem 'capistrano-rvm',		require: false
	gem 'capistrano-rails',	 	require: false
	gem 'capistrano-bundler', 	require: false
	gem 'sitemap_generator'
	gem 'quiet_assets'
	gem 'simplecov', :require => false
end

gem 'authlogic'

# to get recipe data from marmiton.org
gem 'nokogiri'
gem 'marmiton_crawler', '~> 1.0.1' # my first gem :')


#for upload picture
gem 'carrierwave'
gem 'rmagick' # sudo apt-get install libmagickwand-dev

#to build pdf
gem 'pdfkit' # sudo apt-get install wkhtmltopdf
gem 'wkhtmltopdf-binary'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', require: false
end