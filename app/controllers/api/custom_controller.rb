module Api
  class CustomController < ApplicationController  
    def hello
      render status: :ok, json: { message: 'Hello' }
    end
  end
end
