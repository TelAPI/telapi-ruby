module Telapi
  # Wraps TelAPI Notification functionality
  class Notification < Resource
    class << self

      # Returns a resource collection containing Telapi::Notification objects
      # See http://www.telapi.com/docs/api/rest/notifications/list/
      #
      # Also, notifications can be scoped to a call, see Telapi::Call::notifications
      #
      # Optional params is a hash containing:
      # +Log+:: 0 (error), 1 (warning), or 2 (info)
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Notifications'], optional_params)
        ResourceCollection.new(response, 'notifications', self)
      end

      # Returns a Telapi::Notification object given its id
      # See http://www.telapi.com/docs/api/rest/notifications/view/
      def get(id)
        response = Network.get(['Notifications', id])
        Notification.new(response)
      end

    end
  end
end