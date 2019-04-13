# frozen_string_literal: true

# Payments Controller class
class PaymentsController < ApplicationController
  include PaymentsControllerHelper

  def create
    installment = load_installment params[:installment_id]

    if installment.amount == params[:amount].to_i
      payment = create_payment installment.id
      respond status: 'success', message: 'payment successfully made',
              payment: payment.as_json(include: [:installment])
    else
      respond status: 'failure', installment: installment,
              message: 'incorrect amount for that installment'
    end
  end

  private

  def create_payment(installment_id)
    Payment.create(installment_id: installment_id)
  end
end
