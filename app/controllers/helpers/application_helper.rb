# frozen_string_literal: true

# application helper
module ApplicationHelper
  def calculate_eligible_loans
    user_info = session[:current_user_info]
    savings = (user_info[:income] - user_info[:expenses]) * 0.5
    return [] unless savings >= 1000

    @loan_amounts = loan_amounts round_to_thousand(savings.to_int)
    interest_rate = interest_rate user_info[:credit_score]
    build_loan_info @loan_amounts, interest_rate
  end

  def build_loan_info(amounts, rate)
    amounts.map do |amount|
      total_due = rate * amount + amount
      {
        amount: amount,
        interest: rate * amount,
        total_due: total_due,
        installments: build_installment_info(total_due)
      }
    end
  end

  def build_installment_info(total)
    Array.new(4) do |i|
      {
        amount: (total / 4).to_i,
        due_date: ((i + 1) * 7).days.from_now
      }
    end
  end

  def round_to_thousand(amount)
    (amount + 500) / 1000 * 1000
  end

  def loan_amounts(max)
    divider = 1
    amounts = []
    while max / divider >= 1000
      amount = round_to_thousand(max / divider)
      amounts << amount unless amounts.include? amount
      divider += 1
    end
    amounts
  end

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
  def interest_rate(credit_score)
    case credit_score
    when 300...350 then 0.23
    when 350...400 then 0.21
    when 400...450 then 0.19
    when 450...500 then 0.17
    when 500...550 then 0.15
    when 550...600 then 0.13
    when 600...650 then 0.11
    when 650...700 then 0.09
    when 700...750 then 0.07
    when 750...800 then 0.05
    when 800..850 then 0.03
    else 0 #TODO raise exception
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
end