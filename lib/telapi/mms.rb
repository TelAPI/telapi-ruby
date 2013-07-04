module Telapi
  # Wraps TelAPI MMS Message functionality
  class MMS < Resource
    class << self
      MAX_BODY_LENGTH = 160

      # Returns a resource collection containing Telapi::MMS objects
      #
      # Optional params is a hash containing:
      # +To+:: mobile phone number
      # +From+:: TelAPI or mobile phone number
      # +DateSent+:: date in the following format: YYYY-MM-DD
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['MMS', 'Messages'], optional_params)
        ResourceCollection.new(response, 'mms_messages', self)
      end

      # Returns a specific Telapi::Message object given its id
      def get(id)
        response = Network.get(['MMS', 'Messages', id])
        Message.new(response)
      end

      # Creates an MMS Message, returning a Telapi::MMS object
      #
      # Required params:
      # +to+:: mobile phone number
      # +from+:: TelAPI or mobile phone number
      # +body+:: plain text up to 160 characters in length
      # +attachment+:: URL for MMS attachment
      #
      # Optional param:
      # +status_callback+:: valid URL

      def create(to, from, body, attachment, status_callback=nil)
        raise RangeError, "Body must be between 0 and #{MAX_BODY_LENGTH} characters" if body.length>MAX_BODY_LENGTH || body.length==0
        opts = { :To => to, :From => from, :Body => body, :Attachment => attachment, :StatusCallback => status_callback }
        response = Network.post(['MMS', 'Messages'], opts)
        MMS.new(response)
      end

    end
  end
end
