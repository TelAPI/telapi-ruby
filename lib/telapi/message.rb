module Telapi
  # Wraps TelAPI SMS Message functionality
  class Message < Resource
    class << self
      MAX_BODY_LENGTH = 160

      # Returns a resource collection containing Telapi::Message objects
      # See http://www.telapi.com/docs/api/rest/sms/list/
      #
      # Optional params is a hash containing:
      # +To+:: mobile phone number
      # +From+:: TelAPI or mobile phone number
      # +DateSent+:: date in the following format: YYYY-MM-DD
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['SMS', 'Messages'], optional_params)
        ResourceCollection.new(response, 'sms_messages', self)
      end

      # Returns a specific Telapi::Message object given its id
      # See http://www.telapi.com/docs/api/rest/sms/view/
      def get(id)
        response = Network.get(['SMS', 'Messages', id])
        Message.new(response)
      end

      # Creates an SMS Message, returning a Telapi::Message object
      # See http://www.telapi.com/docs/api/rest/sms/send/
      #
      # Required params:
      # +to+:: mobile phone number
      # +from+:: TelAPI or mobile phone number
      # +body+:: plain text up to 160 characters in length
      #
      # Optional params:
      # +status_callback+:: valid URL
      def create(to, from, body, status_callback=nil)
        raise RangeError, "Body must be between 0 and #{MAX_BODY_LENGTH} characters" if body.length>MAX_BODY_LENGTH || body.length==0
        opts = { :To => to, :From => from, :Body => body, :StatusCallback => status_callback }
        response = Network.post(['SMS', 'Messages'], opts)
        Message.new(response)
      end

    end
  end
end
