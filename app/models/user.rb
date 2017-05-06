class User < ApplicationRecord
  has_many :trackings, foreign_key: :owner_id, dependent: :destroy
end
