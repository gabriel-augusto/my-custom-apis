require './app/services/camera/privacy_mode_switch'
require './app/services/camera/status'

module Api
  class CameraController < ApplicationController  
    def switch_camera_mode
      status = Camera::PrivacyModeSwitch.new(authorizer).tap

      render status: :ok, json: { status: status}
    end
    
    def camera_status
      status = Camera::Status.new(authorizer).get

      render status: :ok, json: { status: status }.to_json
    end

    private
    
    def authorizer
      @authorizer ||= Homebridge::Authorizer.new(username: 'Gabriel', password: 'L@Ney1492')  
    end
  end
end
