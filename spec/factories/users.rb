FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    gcm_token { Faker::Crypto.sha256 }
  end
end
