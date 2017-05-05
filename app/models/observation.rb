class Observation < ApplicationRecord
  belongs_to :tracking
  belongs_to :user
end
