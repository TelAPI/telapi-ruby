module Telapi
  # Wraps TelAPI CNAM Caller ID functionality
  class CallerId < Resource
    class << self

      # Returns a Telapi::CallerId object given a phone number
      # See http://www.telapi.com/docs/api/rest/carrier-services/cnam-lookup/
      def lookup(phone_number)
        opts = { :PhoneNumber => phone_number }
        response = Network.get(['CNAM'], opts)
        CallerId.new(response)
      end

    end
  end
end