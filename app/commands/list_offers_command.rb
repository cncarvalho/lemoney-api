class ListOffersCommand
  def initialize(fetch_all = false)
    @fetch_all = fetch_all
  end

  def execute
    if @fetch_all
      Offer.newest
    else
      Offer.available.started.not_expired.newest
    end
  end
end