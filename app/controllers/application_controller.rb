class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordInvalid, with: :respond_unprocessable_entity

  def respond_unprocessable_entity(exception)
    serialized_response = UnprocessableEntitySerializer.new(exception.record).serialized_json
    render json: serialized_response, status: :unprocessable_entity
  end

  def require_admin_access!
    account_is_authorized = account_signed_in? && current_account.is_admin

    return if account_is_authorized

    head(:forbidden)
  end
end
