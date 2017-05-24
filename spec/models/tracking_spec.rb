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

require 'rails_helper'

RSpec.describe Tracking, type: :model do
  let(:owner) { FactoryGirl.create(:user) }
  
  describe 'set id_code before validation' do
    let(:tracking) { owner.trackings.build }

    context 'when saving without id_code' do
      it {
        expect(tracking.save).to be(true)
        expect(tracking.id_code).not_to be_empty
      }
    end
    
    context 'when saving with id_code' do
      before { tracking.id_code = Faker::Crypto.md5 }

      it {
        expect{tracking.save!}.not_to change(tracking, :id_code)
      }
    end
  end
end
