# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Installment, type: :model do
  describe 'Associations' do
    it { should have_one :payment }
    it { should belong_to :loan }
  end

  describe 'Validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :due_date }
  end
end
