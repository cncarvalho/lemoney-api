class DeleteOfferCommand
  def initialize(offer_id)
    @offer_id = offer_id
  end

  def execute
    Offer.destroy(@offer_id)
  end
end