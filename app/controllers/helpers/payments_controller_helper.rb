# frozen_string_literal: true

# payments controller helpers
module PaymentsControllerHelper
  def load_installment(id)
    Installment.find(id)
  end
end