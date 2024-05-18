require './app/services/camera/privacy_mode_switch'
require './app/services/camera/status'

module Api
  module V1
    class CameraController < ApplicationController  
      def switch_privacy_mode
        status = Camera::PrivacyModeSwitch.new(authorizer).tap

        render status: :ok, json: { status: status}
      end
      
      def status
        status = Camera::Status.new(authorizer).get

        render status: :ok, json: { status: status }.to_json
      end

      private
      
      def authorizer
        @authorizer ||= Homebridge::Authorizer.new(username: 'Gabriel', password: 'L@Ney1492')  
      end
    end
  end
end
