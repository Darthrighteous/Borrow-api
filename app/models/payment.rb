# frozen_string_literal: true

# Payment entity class
class Payment < ApplicationRecord
  belongs_to :installment
end
