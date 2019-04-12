# frozen_string_literal: true

# Loan entity model
class Loan < ApplicationRecord
  validates :amount, presence: true
  validates :interest_rate, presence: true

  belongs_to :user

  has_many :installments
end
