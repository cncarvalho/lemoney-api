class OffersController < ApplicationController
  before_action :require_admin_access!, only: %i[create destroy]

  def create
    record = CreateOfferCommand.new(filter_create_attributes).execute
    render json: OfferSerializer.new(record).serialized_json, status: :created
  end

  def destroy
    DeleteOfferCommand.new(params[:id]).execute
    render json: nil, status: :no_content
  end

  private

  def filter_create_attributes
    permitted_params = %i[advertiser_name available description ends_at premium starts_at url]
    params.require(:offer).permit(permitted_params)
  end
end
