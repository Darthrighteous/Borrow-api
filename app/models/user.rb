class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :income, presence: true
  validates :credit_score, presence: true

  has_many :loans
end
