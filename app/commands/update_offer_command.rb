class UpdateOfferCommand
  def initialize(offer_id, offer_attributes)
    @offer_id = offer_id
    @offer_attributes = offer_attributes
  end

  def execute
    offer = Offer.find(@offer_id)
    offer.update!(@offer_attributes)
    offer
  end
end