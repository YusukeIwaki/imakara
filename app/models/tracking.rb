class Tracking < ApplicationRecord
  belongs_to :owner, class_name: User.to_s
  has_many :observations
  has_many :observers, through: :observations, source: :user
end
