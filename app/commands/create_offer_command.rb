class CreateOfferCommand
  def initialize(offer_attributes)
    @offer_attributes = offer_attributes
  end

  def execute
    Offer.create!(@offer_attributes)
  end
end