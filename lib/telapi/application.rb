module Telapi
  # Wraps TelAPI Application functionality
  class Application < Resource
    class << self

      # Returns a resource collection containing Telapi::Application objects
      # See http://www.telapi.com/docs/api/rest/applications/list/
      #
      # Optional params is a hash containing:
      # +FriendlyName+:: string
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Applications'], optional_params)
        ResourceCollection.new(response, 'applications', self)
      end

      # Returns a Telapi::Application object given its id
      # See http://www.telapi.com/docs/api/rest/applications/view/
      def get(id)
        response = Network.get(['Applications', id])
        Application.new(response)
      end

      # Creates an application, returning a Telapi::Application object
      # See http://www.telapi.com/docs/api/rest/applications/create/
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
      def create(optional_params = {})
        response = Network.post(['Applications'], optional_params)
        Application.new(response)
      end

      # Updates an application, returning a Telapi::Application object
      # See http://www.telapi.com/docs/api/rest/applications/update/
      #
      # Required params:
      # +id+:: application id
      #
      # Optional params is a hash supporting same options under ::create
      def update(id, optional_params = {})
        response = Network.post(['Applications', id], optional_params)
        Application.new(response)
      end

      # Deletes an application, returning a Telapi::Application object
      # See http://www.telapi.com/docs/api/rest/applications/delete/
      #
      # Required params:
      # +id+:: application id
      def delete(id)
        response = Network.delete(['Applications', id])
        Application.new(response)
      end

    end

    # See ::update
    def update(optional_params = {})
      self.class.update(self.sid, optional_params)
    end

    # See ::delete
    def delete(optional_params = {})
      self.class.delete(self.sid)
    end

  end
end
