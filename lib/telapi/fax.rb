module Telapi
  # Wraps TelAPI Fax Fax functionality
  class Fax < Resource
    class << self

      # Returns a resource collection containing Telapi::Fax objects
      # See http://www.telapi.com/docs/api/rest/faxes/list/
      #
      # Optional params is a hash containing:
      # +To+:: mobile phone number
      # +From+:: TelAPI or mobile phone number
      # +StartTime+:: date in the following format: YYYY-MM-DD
      # +Status+:: sending, queued, receiving, comm-error, call-dropped
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Faxes'], optional_params)
        ResourceCollection.new(response, 'faxes', self)
      end

      # Returns a specific Telapi::Fax object given its id
      # See http://www.telapi.com/docs/api/rest/faxes/view/
      def get(id)
        response = Network.get(['Faxes', id])
        Fax.new(response)
      end

      # Creates a Fax, returning a Telapi::Fax object
      # See http://www.telapi.com/docs/api/rest/faxes/send/
      #
      # Required params:
      # +to+:: mobile phone number
      # +from+:: TelAPI or mobile phone number
      # +url+:: valid URL of the media file to be faxed
      #
      # Optional params:
      # +status_callback+:: valid URL
      # +status_callback+:: (POST) or GET
      def create(to, from, url, optional_params = {})
        opts = { :To => to, :From => from, :Url => url }.merge(optional_params)
        response = Network.post(['Faxes'], opts)
        Fax.new(response)
      end

    end
  end
end
