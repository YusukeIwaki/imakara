# == Schema Information
#
# Table name: observations
#
#  id          :integer          not null, primary key
#  tracking_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Observation < ApplicationRecord
  belongs_to :tracking
  belongs_to :user
end
