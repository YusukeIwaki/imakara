FactoryGirl.define do
  factory :location_log do
    association :tracking, factory: :tracking
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    accuracy { Faker::Number.normal(100, 100).abs }
  end
end
