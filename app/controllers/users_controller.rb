# frozen_string_literal: true

# User controller
class UsersController < ApplicationController

  def show
    respond status: 'success',
            message: 'profile information successfully fetched',
            profile_info: session[:current_user_info]
  end
end
