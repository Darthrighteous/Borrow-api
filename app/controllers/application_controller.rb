# frozen_string_literal: true

# Application Controller class
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Response
  include ExceptionHandler

  before_action :set_user_info

  def set_user_info
    authenticate_or_request_with_http_token do |id|
      session[:current_user_info] = User.find(id)
    end
  end
end
