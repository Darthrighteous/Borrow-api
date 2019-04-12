# frozen_string_literal: true

# loans controller helpers
module LoanControllerHelper
  def eligible_for?(amount)
    @eligible_loans.include? amount
  end

  def calculate_eligible_loans
    user_info = session[:current_user_info]
    income = session[:current_user_info][:income]
    expenses = session[:current_user_info]
    debugger

    %w[10000 20000 30000]
  end
end