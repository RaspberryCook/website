class ErrorsController < ApplicationController
  def not_found
  	render(:status => 404)
	@title = '404'
  end

  def internal_server_error
  	render(:status => 500)
	@title = '500'
  end
end
