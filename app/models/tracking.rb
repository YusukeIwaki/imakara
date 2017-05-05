class Tracking < ApplicationRecord
  belongs_to :owner, class_name: User.to_s
end
