class ListOffersCommand
  def execute
    Offer.available.started.not_expired
  end
end