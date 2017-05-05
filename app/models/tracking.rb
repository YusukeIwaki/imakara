class Tracking < ApplicationRecord
  belongs_to :owner, class_name: User.to_s
  has_many :observations
  has_many :observers, class_name: User.to_s, through: :observations, foreign_key: :user_id
  
  before_validation :set_code
  
  private
  
  def set_code
    return true if self.code.present?
    
    10.times do
      new_code = SecureRandom.uuid
      if not Tracking.where(code: new_code).exists?
        self.code = new_code
        return true
      end
    end  
    false
  end
end
