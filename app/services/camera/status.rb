require './app/services/homebridge/authorizer'

module Camera
  class Status
    API_URL = "http://127.0.0.1:8581/api/accessories/ace9bd99965754a9e316ae04bc82c48645d912dada5e7f7f19315ecdc05e224b".freeze

    STATUS = { 0 => 'off', 1 => 'on' }

    def initialize(authorizer = Homebridge::Authorizer.new)
      @authorizer = authorizer
    end

    def get
      uri = URI(API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = false

      request = Net::HTTP::Get.new(uri.path)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@authorizer.key}"

      response = http.request(request)

      if response.code == "200"
        status = STATUS[JSON.parse(response.body)['values']['On']]

        return status
      else
        raise "Failed to get camera status. Response status: #{response.code} body: #{response.body}"
      end
    end
  end
end
