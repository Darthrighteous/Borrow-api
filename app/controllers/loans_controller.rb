# frozen_string_literal: true

# Loans controller class
class LoansController < ApplicationController
  include LoanControllerHelper

  before_action :eligible_loans_info
  before_action :loan_info

  def create
    if @loan_info
      create_loan @loan_info
      respond({ status: 'success', loan_info: loan_info,
                message: 'loan granted successfully' }, :created)
    else
      respond({ status: 'failure', loans: @eligible_loans,
                message: 'you are not eligible for that amount' }, :forbidden)
    end
  end

  private

  def create_loan(info)
    Loan.create(
      amount: info[:amount],
      interest_rate: info[:interest],
      user_id: session[:current_user_info][:id]
    )
  end

  def loan_info
    @loan_info = @eligible_loans.find do |loan|
      loan[:amount] == params[:amount].to_i
    end
  end

  def eligible_loans_info
    @eligible_loans = calculate_eligible_loans
  end
end
