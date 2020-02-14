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

  link :image do |object|
    if object.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.image)
    end
  end
end
