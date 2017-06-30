source 'https://rubygems.org'

gem 'rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'json', github: 'flori/json', branch: 'v1.8'


#Database
gem 'sqlite3'# Use sqlite3 as the database for Active Record
gem 'mysql2'  #need to install libmysqlclient-dev

#for avatar
gem 'gravatar'

# Use SCSS & SASS for stylesheets
gem 'sass-rails'
gem 'compass'
gem 'compass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# to manage read/unread status of ActiveRecord objects - and it's fast.
gem 'unread'


#for use old version of rails for attributes
gem 'protected_attributes'

# for Autocomplete system
gem 'rails4-autocomplete'
gem 'rails-jquery-autocomplete'

# Bootstrap
gem 'bootstrap_form'

gem 'will_paginate'#https://github.com/mislav/will_paginate
gem 'will_paginate-bootstrap'

# cache system
gem 'rack-cache'


group :development , :test do
	# Use Capistrano for deployment
	gem 'net-ssh'
	gem 'capistrano',		require: false
	gem 'capistrano-rvm',		require: false
	gem 'capistrano-rails',	 	require: false
	gem 'capistrano-bundler', 	require: false
	gem 'quiet_assets'
	gem 'simplecov', :require => false

	gem 'faker', github: 'stympy/faker'
end

gem 'authlogic'

# to get recipe data from marmiton.org
gem 'nokogiri'
gem 'recipe_scraper', '~>2.2.1' # my first gem :')


#for upload picture
gem 'carrierwave'
gem 'rmagick' # sudo apt-get install libmagickwand-dev

#to build pdf
gem 'pdfkit' # sudo apt-get install wkhtmltopdf
# gem 'wkhtmltopdf-binary'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'


# to slugify routes
gem 'friendly_id', '~> 5.1.0'

group :doc do
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', require: false
	gem 'yard', require: false
end
