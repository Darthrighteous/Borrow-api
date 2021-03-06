# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  include ApplicationHelper

  def index
    respond status: 'success',
            message: 'users successfully retrieved',
            users: User.all
  end

  def show
    @user = User.find(session[:current_user_info][:id])
    respond status: 'success',
            message: 'profile information successfully fetched',
            profile_info: @user.as_json(
              include: [
                loans: { include: [:installments] }
              ]
            ),
            loan_offers: calculate_eligible_loans
  end
end
