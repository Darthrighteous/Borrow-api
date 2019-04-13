# frozen_string_literal: true

# module for error handling
module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidCreditScore < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      respond({ status: 'failure', message: e.to_s }, :not_found)
    end

    rescue_from ExceptionHandler::InvalidCreditScore do
      respond({ status: 'failure', message: 'invalid credit score' },
              :unprocessable_entity)
    end
  end
end
