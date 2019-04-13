# frozen_string_literal: true

# Installment entity class
class Installment < ApplicationRecord
  validates :amount, presence: true
  validates :due_date, presence: true
  validates :status, presence: true,
                     inclusion: { in: %w[pending paid overdue],
                                  message: '%s is not a valid status' }

  belongs_to :loan
  has_one :payment
end
