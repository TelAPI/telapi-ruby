module Telapi
  # Wraps TelAPI Usage functionality
  class Usage < Resource
    class << self

      # Returns a resource collection containing Telapi::Usage objects
      # See http://www.telapi.com/docs/api/rest/accounts/list-usages/
      #
      # Optional params is a hash containing:
      # +Day+:: day in the following format: DD
      # +Month+:: month in the following format: MM
      # +Year+:: year in the following format: YYYY
      # +Product+:: integer representing a product
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Usages'], optional_params)
        ResourceCollection.new(response, 'usages', self)
      end

      # Returns a specific Telapi::Usage object given its id
      # See http://www.telapi.com/docs/api/rest/accounts/view-usage/
      def get(id)
        response = Network.get(['Usages', id])
        Usage.new(response)
      end

    end
  end
end
