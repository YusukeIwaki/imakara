require 'rails_helper'

RSpec.describe "Observe tracking", :type => :request do
  describe 'POST /trackings/:tracking_id/observe' do
    context '新規ユーザが初めてTrackingをobserve' do
      let(:tracking) { FactoryGirl.create(:tracking) }
      let(:user) { FactoryGirl.create(:user) }
      
      it 'HTTP 200 OK' do
        post tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        expect(response).to have_http_status(200)
      end
    end
    
    context '既存ユーザが初めてTrackingをobserve' do
      let(:tracking) { FactoryGirl.create(:tracking) }
      let(:another_tracking) { FactoryGirl.create(:tracking) }
      let(:user) { another_tracking.owner }
      
      it 'HTTP 200 OK' do
        post tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        expect(response).to have_http_status(200)
      end
    end

    context 'Trackingのオーナーがobserve' do
      let(:tracking) { FactoryGirl.create(:tracking) }
      let(:user) { tracking.owner }

      it 'HTTP 400 Bad Request' do
        post tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        expect(response).to have_http_status(400)
      end
    end

    context '以前と同じTrackingをobserve' do
      let(:tracking) { FactoryGirl.create(:tracking) }
      let(:user) { FactoryGirl.create(:user) }
      
      before {
        tracking
      }

      it 'HTTP 200 OK' do
        post tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        expect(response).to have_http_status(200)
      end
      
    end

    context '別のユーザがobserveしているTrackingをobserve' do
      let(:tracking) { FactoryGirl.create(:tracking) }
      let(:user) { FactoryGirl.create(:user) }
      let(:another_user) { FactoryGirl.create(:user) }
      
      before {
        tracking.observations.create!(user: another_user)
      }

      it 'HTTP 200 OK' do
        post tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        expect(response).to have_http_status(200)
      end
      
    end
  end

  describe 'DELETE /trackings/:tracking_id/observe' do
    let(:observation) { FactoryGirl.create(:observation) }
    let(:tracking) { observation.tracking }
    let(:user) { observation.user }
    let(:user_id) { user.id }

    context '1つだけTrackingをobserveしている' do
      it 'ユーザも消える' do
        delete tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        
        expect(response).to have_http_status(204)
        expect{User.find(user_id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context '2つ以上Trackingをobserveしている' do
      let!(:another_observation) { FactoryGirl.create(:observation, user_id: user_id) }

      it 'ユーザは消えない' do
        delete tracking_observe_path(tracking_id: tracking.id_code), params: { user: user.slice(:name, :gcm_token) }
        
        expect(response).to have_http_status(204)
        expect{User.find(user_id)}.not_to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end