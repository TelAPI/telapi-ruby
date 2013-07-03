module Telapi
  # Wraps TelAPI MMS Message functionality
  class MMS < Resource
    class << self
      MAX_BODY_LENGTH = 160

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

      def create(from, to, body, attachment, status_callback=nil)
        raise RangeError, "Body must be between 0 and #{MAX_BODY_LENGTH} characters" if body.length>MAX_BODY_LENGTH || body.length==0
        opts = { :From => from, :To => to, :Body => body, :Attachment => attachment, :StatusCallback => status_callback }
        response = Network.post(['MMS', 'Messages'], opts)
        MMS.new(response)
      end

    end
  end
end