FactoryGirl.define do
  factory :tracking do
    #id_code { SecureRandom.uuid }
    association :owner, factory: :user
  end
end
