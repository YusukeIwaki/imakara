class User < ApplicationRecord
  validates :gcm_token, presence: true
  has_many :trackings, foreign_key: :owner_id, dependent: :destroy
end
