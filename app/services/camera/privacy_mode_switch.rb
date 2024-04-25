require './app/services/homebridge/authorizer'

module Camera
  class PrivacyModeSwitch
    API_URL = "http://127.0.0.1:8581/api/accessories/ace9bd99965754a9e316ae04bc82c48645d912dada5e7f7f19315ecdc05e224b".freeze

    OPPOSITE = { "on" => 0, "off" => 1 }

    def initialize(authorizer = Homebridge::Authorizer.new)
      @authorizer = authorizer
    end

    def tap
      send_request
      (OPPOSITE.keys - [status]).first
    end

    private

    def send_request
      uri = URI(API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false

      request = Net::HTTP::Put.new(uri.path)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@authorizer.key}"
      request.body = { characteristicType: "On", value: OPPOSITE[status] }.to_json

      http.request(request)
    end

    def status
      @status ||= Status.new(@authorizer).get
    end
  end
end
