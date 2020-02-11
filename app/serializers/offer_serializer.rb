class OfferSerializer
  include FastJsonapi::ObjectSerializer

  attributes :advertiser_name,
             :available,
             :created_at,
             :description,
             :ends_at,
             :premium,
             :starts_at,
             :updated_at,
             :url
end
