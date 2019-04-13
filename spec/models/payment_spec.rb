# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'Associations' do
    it { should belong_to :installment }
  end
end