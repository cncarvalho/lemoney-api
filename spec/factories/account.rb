FactoryBot.define do
  factory :account do
    provider { 'email' }
    email { 'development@lemoney.com' }
    password { 'secret' }
  end
end