# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  gcm_token  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :gcm_token, presence: true
  has_many :trackings, foreign_key: :owner_id, dependent: :destroy
end
