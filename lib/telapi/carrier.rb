module Telapi
  # Wraps TelAPI Carrier functionality
  class Carrier < Resource
    class << self

      # Returns a Telapi::Carrier object given a phone number
      # See http://www.telapi.com/docs/api/rest/carrier-services/carrier-lookup/
      def lookup(phone_number)
        opts = { :PhoneNumber => phone_number }
        response = Network.get(['Carrier'], opts)
        Carrier.new(response)
      end

    end
  end
end