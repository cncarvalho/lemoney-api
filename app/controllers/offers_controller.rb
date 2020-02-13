class OffersController < ApplicationController
  #before_action :require_admin_access!, only: %i[create destroy update]

  def create
    record = CreateOfferCommand.new(filter_permitted_attributes).execute
    render json: OfferSerializer.new(record).serialized_json, status: :created
  end

  def destroy
    DeleteOfferCommand.new(params[:id]).execute
    render json: nil, status: :no_content
  end

  def index
    records = ListOffersCommand.new.execute
    render json: OfferSerializer.new(records).serialized_json, status: :ok
  end

  def show
    record = FetchOfferCommand.new(params[:id]).execute
    render json: OfferSerializer.new(record).serialized_json, status: :ok
  end

  def update
    record = UpdateOfferCommand.new(params[:id], filter_permitted_attributes).execute
    render json: OfferSerializer.new(record).serialized_json, status: :ok
  end

  private

  def filter_permitted_attributes
    params.require(:offer).permit(list_permitted_params)
  end

  def list_permitted_params
    %i[advertiser_name available description ends_at premium starts_at url]
  end
end
