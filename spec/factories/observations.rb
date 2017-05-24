# == Schema Information
#
# Table name: observations
#
#  id          :integer          not null, primary key
#  tracking_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :observation do
    association :tracking, factory: :tracking
    association :user, factory: :user
  end
end
