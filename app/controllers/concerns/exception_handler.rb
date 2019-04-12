# frozen_string_literal: true

# module for global error handling
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      respond({ status: 'failure', message: e.to_s }, :not_found)
    end
  end
end
