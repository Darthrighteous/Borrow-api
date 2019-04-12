# frozen_string_literal: true

# Payments Controller class
class PaymentsController < ApplicationController
  def create
    respond status: 'success',
            message: 'payment successfully made',
            installment: 'installment info',
            loan: 'loan_info'
  end
end
