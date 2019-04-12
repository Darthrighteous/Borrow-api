# frozen_string_literal: true

# Installment entity class
class Installment < ApplicationRecord
  validates :amount, presence: true
  validates :due_date, presence: true

  belongs_to :loan
  has_one :payment
end
