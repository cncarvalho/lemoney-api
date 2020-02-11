FactoryBot.define do
  factory :offer do
    advertiser_name { 'Walmart,' }
    url  { 'https://www.walmart.com' }
    description { '10% discount on books' }
    starts_at { 1.day.ago }
    ends_at { 1.week.from_now }
    premium { false }
    available { true }
  end
end