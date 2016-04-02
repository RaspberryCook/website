namespace :ruby_on_rails do


	desc 'Install all gems depandancies'
	task :bundle_install do 

		on roles(:web) do
	    	within release_path do
	    		# here we execute a simple 'bundle install on the raspberry'
	    		execute :bundle, :install 
	    	end
	    end
		
	end

	desc 'migrate all db'
	task :db_migrate do 

		on roles(:web) do
	    	within release_path do
	    		execute 'cd #{release_path} && rake RAILS_ENV=production db:migrate'
	    	end
	    end
		
	end

	desc 'precompile assets'
	task :assets_precompile do 

		on roles(:web) do
	    	within release_path do
	    		execute 'cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile'
	    	end
	    end
		
	end

	desc 'copy database.yml files'
	task :copy_database_configuration do 

		on roles(:web) do
	    	within release_path do
	    		execute "cp /var/www/raspberry_cook/private/database.yml #{release_path}/config/"
	    	end
	    end
		
	end

	# need to add these tasks
	# RAILS_ENV=production rake db:create db:schema:load
	# cp db/development.sqlite3 db/production.sqlite3
	# RAILS_ENV=production bundle exec rake assets:precompile
	# from http://stackoverflow.com/questions/8453400/how-to-copy-data-in-development-db-to-product-db-using-sqlite


end