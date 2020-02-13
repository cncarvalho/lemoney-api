class FetchOfferCommand
  def initialize(offer_id)
    @offer_id = offer_id
  end

  def execute
    Offer.find(@offer_id)
  end
end