# == Schema Information
#
# Table name: location_logs
#
#  id          :integer          not null, primary key
#  tracking_id :integer          not null
#  lat         :decimal(8, 6)    not null
#  lon         :decimal(9, 6)    not null
#  accuracy    :decimal(10, 6)
#  created_at  :datetime
#

FactoryGirl.define do
  factory :location_log do
    association :tracking, factory: :tracking
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    accuracy { Faker::Number.normal(100, 100).abs }
  end
end
