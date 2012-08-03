module Telapi
  # Wraps TelAPI Available Phone Number functionality
  class AvailablePhoneNumber < Resource
    class << self

      # Returns a resource collection containing Telapi::AvailablePhoneNumber objects
      # See http://www.telapi.com/docs/api/rest/available-phone-numbers/list/
      #
      # Required params:
      # +country_code_iso+:: country code (ISO), see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # Optional params is a hash containing:
      # +AreaCode+:: valid area code, e.g. 415
      # +Contains+:: 0-9, lower and upper case letters of the alphabet (Aa-Zz), or *
      # +InRegion+:: valid region (state or province) abbreviation
      # +InPostalCode+:: valid postal code
      def list(country_code_iso, optional_params = {})
        response = Network.get(['AvailablePhoneNumbers', country_code_iso, 'Local'], optional_params)
        ResourceCollection.new(response, 'available_phone_numbers', self)
      end

    end
  end
end