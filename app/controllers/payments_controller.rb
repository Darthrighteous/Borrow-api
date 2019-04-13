# frozen_string_literal: true

# Payments Controller class
class PaymentsController < ApplicationController
  include PaymentsControllerHelper

  before_action :load_installment

  def create
    if @installment[:amount] == params[:amount].to_i
      create_payment
      update_installment_status
      update_credit_score

      respond status: 'success', message: 'payment successfully made',
              payment: @payment.as_json(include: [:installment])
    else
      respond({ status: 'failure', installment: @installment,
                message: 'incorrect amount for that installment' }, :forbidden)
    end
  end

  private

  def create_payment
    @payment = Payment.create(
      installment_id: @installment[:id],
      created_at: params[:date_paid]
    )
  end

  def update_installment_status
    sts = @payment[:created_at] > @installment[:due_date] ? 'overdue' : 'paid'
    @installment.update(status: sts)
  end

  def update_credit_score
    if @installment[:status] == 'paid'
      @installment.loan.user.increment('credit_score', 15)
    else
      @installment.loan.user.decrement('credit_score', 20)
    end
  end

  def load_installment
    @installment = Installment.find(params[:installment_id])
  end
end
