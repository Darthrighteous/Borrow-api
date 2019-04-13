# frozen_string_literal: true

# Loans controller class
class LoansController < ApplicationController
  include LoanControllerHelper

  before_action :loan_info

  def create
    if eligible_for? params[:amount].to_i
      loan_info = @eligible_loans.find do |loan|
        loan[:amount] == params[:amount].to_i
      end
      respond status: 'success', loan_info: loan_info,
              message: 'loan granted successfully'
    else
      respond status: 'success', loans: @eligible_loans,
              message: 'you are not eligible for that amount'
    end
  end

  private

  def loan_info
    @eligible_loans = calculate_eligible_loans
  end
end
