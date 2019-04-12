# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'Associations' do
    it { should have_many :installments }
    it { should belong_to :user }
  end

  describe 'Validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :interest_rate }
  end
end
