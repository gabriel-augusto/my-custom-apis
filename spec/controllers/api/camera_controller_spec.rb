require 'rails_helper'

module Api
  module V1
    RSpec.describe CameraController do
      it 'POST #switch_privacy_mode' do
        post :switch_privacy_mode

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).keys).to include('status')
      end

      it 'GET #status' do
        get :status

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).keys).to include('status')
      end
    end
  end
end