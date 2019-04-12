# frozen_string_literal: true

# Loans controller class
class LoansController < ApplicationController
  include LoanControllerHelper

  before_action :loan_info

  def create
    if eligible_for? params[:amount]
      respond status: 'success',
              message: 'loan granted successfully',
              loan_info: 'loan information'
    else
      render json: { message: 'no loan for you' }
    end
  end

  private

  def loan_info
    @eligible_loans = calculate_eligible_loans
  end
end
