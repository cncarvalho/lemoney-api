class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordInvalid, with: :respond_unprocessable_entity

  def respond_unprocessable_entity(exception)
    serialized_response = UnprocessableEntitySerializer.new(exception.record).serialized_json
    render json: serialized_response, status: :unprocessable_entity
  end
end
