class Offer < ApplicationRecord
  validates :url, uri: true
  validates_length_of :description, maximum: 500
  validates_presence_of :advertiser_name, :description, :starts_at, :url
  validates_uniqueness_of :advertiser_name, case_sensitive: false
end
