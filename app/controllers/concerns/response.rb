# frozen_string_literal: true

module Response
  def respond(payload, status = :ok)
    render json: payload, status: status
  end
end
