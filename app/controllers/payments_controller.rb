# frozen_string_literal: true

# Payments Controller class
class PaymentsController < ApplicationController
  before_action :load_installment

  def create
    if @installment[:status] != 'pending'
      raise AlreadyPaidError.new(@installment), 'installment already paid'
    end

    if @installment[:amount] != params[:amount].to_i
      raise InvalidPaymentAmount.new(@installment), 'invalid payment amount'
    end

    create_payment
    update_installment_status

    respond status: 'success', message: 'payment successfully made',
            payment: @payment.as_json(include: [:installment])
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
    update_credit_score
  end

  def update_credit_score
    user = @installment.loan.user
    if @installment[:status] == 'paid'
      user.increment('credit_score', 15)
    else
      user.decrement('credit_score', 20)
    end
    user[:credit_score] > 850 && user.update(credit_score: 850)
    user[:credit_score] < 350 && user.update(credit_score: 350)
    user.save!
  end

  def load_installment
    @installment = Installment.find(params[:installment_id])
  end
end
