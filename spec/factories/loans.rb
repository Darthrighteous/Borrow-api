FactoryBot.define do
  factory :loan do
    amount { 1 }
    interest_rate { "9.99" }
    user_id { nil }
  end
end
