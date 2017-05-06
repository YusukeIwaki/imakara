class LocationLog < ApplicationRecord
  belongs_to :tracking
  
  scope :recent_enough_for_cached_view, -> { where('created_at > ?', 5.minutes.ago) }
end
