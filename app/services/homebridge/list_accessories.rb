module Homebridge
  class ListAccessories
    ACCESSORIES_API_URL = "http://127.0.0.1:8581/api/accessories".freeze

    def initialize(authorizer = Homebridge::Authorizer.new)
      @authorizer = authorizer
    end

    def call
      JSON.parse(response.body)
    rescue StandardError => e
      puts "Error occurred while fetching accessories: #{e.message}"
      []
    end

    private

    def uri
      @uri ||= URI(ACCESSORIES_API_URL)
    end

    def request
      @request ||= begin
          req = Net::HTTP::Get.new(uri)
          req["Authorization"] = "Bearer #{@authorizer.key}"
          req["Accept"] = "application/json"
          req
        end
    end

    def response
      @response ||= Net::HTTP.new(uri.host, uri.port).request(request)
    end
  end
end
