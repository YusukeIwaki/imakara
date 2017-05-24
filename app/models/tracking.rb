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

class Tracking < ApplicationRecord
  belongs_to :owner, class_name: User.to_s
  has_many :observations, dependent: :destroy
  has_many :observers, through: :observations, source: :user
  has_many :location_logs, dependent: :destroy
  
  before_validation :set_id_code
  
  private 
  
  def set_id_code
    return true if self.id_code.present?
    
    10.times do
      code = SecureRandom.uuid
      unless Tracking.where(id_code: code).exists? then
        self.id_code = code
        return true
      end
    end

    false
  end
end
