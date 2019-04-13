# frozen_string_literal: true

# module for error handling
module ExceptionHandler
  extend ActiveSupport::Concern

  class CustomError < StandardError
    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end
  end

  class InvalidCreditScore < CustomError; end
  class AlreadyPaidError < CustomError; end
  class InvalidPaymentAmount < CustomError; end

  class DebtorError < CustomError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      respond({ status: 'failure', message: e.to_s }, :not_found)
    end

    rescue_from ExceptionHandler::InvalidCreditScore do |e|
      respond({ status: 'failure', message: e.to_s },
              :unprocessable_entity)
    end

    rescue_from ExceptionHandler::AlreadyPaidError do |e|
      respond({ status: 'failure', message: e.to_s, installment: e.resource },
              :conflict)
    end

    rescue_from ExceptionHandler::InvalidPaymentAmount do |e|
      respond({ status: 'failure', message: e.to_s, installment: e.resource },
              :unprocessable_entity)
    end

    rescue_from ExceptionHandler::DebtorError do |e|
      respond({ status: 'failure', message: e.to_s, loan: e.resource },
              :forbidden)
    end
  end
end
