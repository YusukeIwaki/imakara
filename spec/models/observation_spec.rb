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

require 'rails_helper'

RSpec.describe Observation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
