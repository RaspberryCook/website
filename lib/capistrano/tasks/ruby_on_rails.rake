
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
	    		execute 'rake RAILS_ENV=production db:migrate'
	    	end
	    end
		
	end

	desc 'precompile assets'
	task :assets_precompile do 

		on roles(:web) do
	    	within release_path do
	    		execute 'RAILS_ENV=production bundle exec rake assets:precompile'
	    	end
	    end
		
	end

	






end