# frozen_string_literal: true

# Loan entity model
class Loan < ApplicationRecord
  validates :amount, presence: true
  validates :interest_rate, presence: true

  belongs_to :user

  has_many :installments

  def self.owed?(loan_id)
    installment_count = joins(:installments).where(loans: { id: loan_id }).count
    payment_count = joins(installments: :payment).where(loans: { id: loan_id })
                                                 .count
    payment_count < installment_count
  end
end
