class OffersController < ApplicationController
  def create
    @record = CreateOfferCommand.new(filter_create_attributes).execute
    render json: @record.to_json
  end

  private

  def filter_create_attributes
    permitted_params = %i[advertiser_name available description ends_at premium starts_at url]
    params.require(:offer).permit(permitted_params)
  end
end
