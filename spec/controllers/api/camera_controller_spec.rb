require 'rails_helper'

module Api
  RSpec.describe CameraController do
    it 'POST #switch_camera_mode' do
      post :switch_camera_mode

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).keys).to include('status')
    end

    it 'GET #camera_status' do
      get :camera_status

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).keys).to include('status')
    end
  end
end