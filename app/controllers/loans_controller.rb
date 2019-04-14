# frozen_string_literal: true

# Loans controller class
class LoansController < ApplicationController
  include ApplicationHelper

  before_action :validate_eligibility
  before_action :loan_info

  def create
    if @loan_details
      loan = create_loan @loan_details
      create_installments loan, @loan_details[:installments]

      respond({ status: 'success', loan_info: @loan_details,
                message: 'loan granted successfully' }, :created)
    else
      respond({ status: 'failure', loans: calculate_eligible_loans,
                message: 'you are not eligible for that amount' }, :forbidden)
    end
  end

  private

  def validate_eligibility
    @last_loan = User.find(session[:current_user_info][:id]).loans.last
    # rubocop:disable Style/GuardClause
    if @last_loan && Loan.owed?(@last_loan.id)
      raise DebtorError.new(@last_loan),
            'You must pay off your last loan before requesting another'
    end
    # rubocop:enable Style/GuardClause
  end

  def create_loan(info)
    Loan.create(
      amount: info[:amount],
      interest_rate: info[:interest],
      user_id: session[:current_user_info][:id]
    )
  end

  def create_installments(loan, installments)
    installments.each do |installment|
      Installment.create(
        loan_id: loan.id,
        amount: installment[:amount],
        due_date: installment[:due_date],
        status: 'pending'
      )
    end
  end

  def loan_info
    @loan_details = calculate_eligible_loans.find do |loan|
      loan[:amount] == params[:amount].to_i
    end
  end
end
