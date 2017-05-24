# == Schema Information
#
# Table name: trackings
#
#  id         :integer          not null, primary key
#  id_code    :string(64)       not null
#  owner_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :tracking do
    #id_code { SecureRandom.uuid }
    association :owner, factory: :user
  end
end
