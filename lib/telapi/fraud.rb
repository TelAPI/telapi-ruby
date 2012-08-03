module Telapi
  # Wraps TelAPI Fraud control functionality
  class Fraud < Resource
    class << self

      # Returns a resource collection containing Telapi::Fraud objects
      # See http://www.telapi.com/docs/api/rest/fraud-control/list/
      #
      # Optional params is a hash containing:
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Fraud'], optional_params)
        ResourceCollection.new(response, 'frauds', self)
      end

      # Authorizes destination for outbound calls and sms messages, returns a Telapi::Fraud object
      # See http://www.telapi.com/docs/api/rest/fraud-control/authorize/
      #
      # Required params:
      # +country_code_iso+:: country code (ISO), see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # Optional params is a hash containing:
      # +MobileBreakout+:: (true) or false
      # +LandlineBreakout+:: (true) or false
      # +SmsEnabled+:: (true) or false
      def authorize(country_code_iso, optional_params = {})
        response = Network.post(['Fraud', 'Authorize', country_code_iso], optional_params)
        Fraud.new(response)
      end

      # Extend authorized destination for outbound calls and sms messages, returns a Telapi::Fraud object
      # See http://www.telapi.com/docs/api/rest/fraud-control/extend/
      #
      # Required params:
      # +country_code_iso+:: country code (ISO), see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # Optional params is a hash containing:
      # +MobileBreakout+:: (true) or false
      # +LandlineBreakout+:: (true) or false
      # +SmsEnabled+:: (true) or false
      def extend_authorization(country_code_iso, optional_params = {})
        response = Network.post(['Fraud', 'Extend', country_code_iso], optional_params)
        Fraud.new(response)
      end

      # Blocks destination for outbound calls and sms messages, returns a Telapi::Fraud object
      # See http://www.telapi.com/docs/api/rest/fraud-control/block/
      #
      # Required params:
      # +country_code_iso+:: country code (ISO), see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # Optional params is a hash containing:
      # +MobileBreakout+:: (true) or false
      # +LandlineBreakout+:: (true) or false
      # +SmsEnabled+:: (true) or false
      def block(country_code_iso, optional_params = {})
        response = Network.post(['Fraud', 'Block', country_code_iso], optional_params)
        Fraud.new(response)
      end

      # Whitelist destination for outbound calls and sms messages, returns a Telapi::Fraud object
      # See http://www.telapi.com/docs/api/rest/fraud-control/whitelist/
      #
      # Required params:
      # +country_code_iso+:: country code (ISO), see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # Optional params is a hash containing:
      # +MobileBreakout+:: (true) or false
      # +LandlineBreakout+:: (true) or false
      # +SmsEnabled+:: (true) or false
      def whitelist(country_code_iso, optional_params = {})
        response = Network.post(['Fraud', 'Whitelist', country_code_iso], optional_params)
        Fraud.new(response)
      end

    end
  end
end