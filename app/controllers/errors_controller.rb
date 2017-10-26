# Custom errors pages
class ErrorsController < ApplicationController

  # GET /errors/not_found
  def not_found
    @title = '404'
    @descripion = 'Cette page n\'existe pas'

    render status: 404
  end


  # GET /errors/internal_server_error
  def internal_server_error
    @title = '500'
    @descripion = 'En cours de construction...'

    render status: 500
  end


end
