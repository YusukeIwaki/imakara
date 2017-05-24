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

require 'rails_helper'

RSpec.describe LocationLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
