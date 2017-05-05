class Tracking < ApplicationRecord
  belongs_to :owner, class_name: User.to_s
  has_many :observations
  has_many :observers, class_name: User.to_s, through: :observations, foreign_key: :user_id
end
