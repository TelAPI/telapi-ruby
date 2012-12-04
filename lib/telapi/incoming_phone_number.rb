module Telapi
  # Wraps TelAPI Incoming Phone Number functionality
  class IncomingPhoneNumber < Resource
    class << self

      # Returns a resource collection containing Telapi::IncomingPhoneNumber objects
      # See http://www.telapi.com/docs/api/rest/incoming-phone-numbers/list/
      #
      # Optional params is a hash containing:
      # +PhoneNumber+:: valid TelAPI phone number, e.g. 7325551234
      # +FriendlyName+:: valid domestic format phone number, e.g. 7325551234
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['IncomingPhoneNumbers'], optional_params)
        ResourceCollection.new(response, 'incoming_phone_numbers', self)
      end

      # Returns a Telapi::IncomingPhoneNumber object given its id
      # See http://www.telapi.com/docs/api/rest/incoming-phone-numbers/view/
      def get(id)
        response = Network.get(['IncomingPhoneNumbers', id])
        IncomingPhoneNumber.new(response)
      end

      # Creates a new incoming phone number, returning a Telapi::IncomingPhoneNumber object
      # See http://www.telapi.com/docs/api/rest/incoming-phone-numbers/add-or-delete/
      #
      # Required params:
      # +phone_number+:: area code, e.g. 18052585701
      def create(phone_number)
        opts = { :PhoneNumber => phone_number }
        response = Network.post(['IncomingPhoneNumbers'], opts)
        IncomingPhoneNumber.new(response)
      end

      # Delete an incoming phone number, returning a Telapi::IncomingPhoneNumber object
      # See http://www.telapi.com/docs/api/rest/incoming-phone-numbers/add-or-delete/
      #
      # Required params:
      # +id+:: incoming phone number id
      def delete(id)
        response = Network.delete(['IncomingPhoneNumbers', id])
        IncomingPhoneNumber.new(response)
      end

      # Updates an incoming phone number, returning a Telapi::IncomingPhoneNumber object
      # See http://www.telapi.com/docs/api/rest/incoming-phone-numbers/update/
      #
      # Required params:
      # +id+:: incoming phone number id
      #
      # Optional params is a hash containing:
      # +FriendlyName+:: string
      # +VoiceUrl+:: valid URL
      # +VoiceMethod+:: (POST) or GET
      # +VoiceFallbackUrl+:: valid URL
      # +VoiceFallbackMethod+:: (POST) or GET
      # +VoiceCallerIdLookup+:: true or (false)
      # +SmsUrl+:: valid URL
      # +SmsMethod+:: (POST) or GET
      # +SmsFallbackUrl+:: valid URL
      # +SmsFallbackMethod+:: (POST) or GET
      # +HeartbeatUrl+:: valid URL
      # +HeartbeatMethod+:: (POST) or GET
      # +HangupCallback+:: valid URL
      # +HangupCallbackMethod+:: (POST) or GET
      def update(id, optional_params = {})
        response = Network.post(['IncomingPhoneNumbers', id], optional_params)
        IncomingPhoneNumber.new(response)
      end

    end

    # See ::delete
    def delete
      self.class.delete(self.sid)
    end

    # See ::update
    def update(optional_params = {})
      self.class.update(self.sid, optional_params)
    end

  end
end