class ErrorsController < ApplicationController
  def not_found
  	render(:status => 404)
	@title = '404'
	@descripion = 'Cette page n\'existe pas'
  end

  def internal_server_error
  	render(:status => 500)
	@title = '500'
	@descripion = 'En cours de construction...'
  end
end
