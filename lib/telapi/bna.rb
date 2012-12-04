module Telapi
  # Wraps TelAPI BNA lookup functionality
  class Bna < Resource
    class << self

      # Returns a Telapi::Bna object given a phone number
      # See http://www.telapi.com/docs/api/rest/carrier-services/bna-lookup/
      def lookup(phone_number)
        opts = { :PhoneNumber => phone_number }
        response = Network.get(['BNA'], opts)
        Bna.new(response)
      end

    end
  end
end