class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_headers

  def set_headers
    if session[:jwt]
      @jwt = session[:jwt]
      Unirest.default_header("Authorization", "Bearer #{session[:jwt]}")
    else
      Unirest.clear_default_headers()
    end
  end

  # def current_user
  #   if session[:jwt]
  #     @current_user = 
end
