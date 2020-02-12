class Offer < ApplicationRecord
  scope :available, -> { where(available: true) }
  scope :not_expired, -> { where('ends_at > ? or ends_at IS NULL', Date.today) }
  scope :started, -> { where('starts_at <= ?', Date.today) }

  validates :url, uri: true
  validates_length_of :description, maximum: 500
  validates_presence_of :advertiser_name, :description, :starts_at, :url
  validates_uniqueness_of :advertiser_name, case_sensitive: false
end
