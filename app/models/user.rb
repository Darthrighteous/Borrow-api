class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :income, presence: true
  validates :credit_score, presence: true,
                           numericality: { less_than_or_equal_to: 850,
                                           greater_than_or_equal_to: 300 }

  has_many :loans

  def self.debtor?(user_id)
    last_loan = User.find(user_id).loans.last
    last_loan ? Loan.owed?(last_loan.id) : false
  end
end
