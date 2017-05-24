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

class LocationLog < ApplicationRecord
  belongs_to :tracking, touch: true
  validates :lat, presence: true, inclusion: -90..90
  validates :lon, presence: true, inclusion: -180..180
  validates :accuracy, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  
  scope :recent_enough_for_cached_view, -> { where('created_at > ?', 5.minutes.ago) }
end
