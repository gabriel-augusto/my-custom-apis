module Api
  module V1
    class DevicesController < ApplicationController
      def index
        status = Homebridge::ListAccessories.new(authorizer).call

        render status: :ok, json: { status: status }.to_json
      end

      private
      
      def authorizer
        @authorizer ||= Homebridge::Authorizer.new(username: 'Gabriel', password: 'L@Ney1492')  
      end
    end
  end
end
