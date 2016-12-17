# Custom errors pages
class ErrorsController < ApplicationController

  # GET /errors/not_found
  def not_found
  	render(:status => 404)
	@title = '404'
	@descripion = 'Cette page n\'existe pas'
  end


  # GET /errors/internal_server_error
  def internal_server_error
  	render(:status => 500)
	@title = '500'
	@descripion = 'En cours de construction...'
  end

  
end
