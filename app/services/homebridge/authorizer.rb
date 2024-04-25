module Homebridge
  class Authorizer
    API_URL = "http://127.0.0.1:8581/api/auth/login".freeze

    def initialize(username: nil, password: nil)
      @username = username || ENV['HOMEBRIDGE_USER']
      @password = password || ENV['HOMEBRIDGE_PASSWORD']
    end

    def key
      @key ||= send_request
    end

    private

    def send_request
      uri = URI(API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false

      request = Net::HTTP::Post.new(uri.path)
      request["Content-Type"] = "application/json"
      request.body = { username: @username, password: @password }.to_json

      response = http.request(request)

      if response.code == "201"
        authorization_key = JSON.parse(response.body)['access_token']

        return authorization_key
      end
      
      raise "Failed to authorize homebridge access. Response status: #{response.code} body: #{response.body}"
    end
  end
end
