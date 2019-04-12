FactoryBot.define do
  factory :installment do
    loan_id { nil }
    amount { 1 }
    due_date { "2019-04-12 15:29:29" }
  end
end
