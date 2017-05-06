FactoryGirl.define do
  factory :observation do
    association :tracking, factory: :tracking
    association :user, factory: :user
  end
end
