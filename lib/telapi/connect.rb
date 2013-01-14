module Telapi
  # Wraps TelAPI Connect functionality
  class Connect < Resource
    class << self

      # Returns a resource collection containing Telapi::Connect objects
      # See http://www.telapi.com/docs/api/rest/connect/list/
      #
      # Optional params is a hash containing:
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Connect'], optional_params)
        ResourceCollection.new(response, 'connects', self)
      end

      # Returns a Telapi::Connect object given its id
      # See http://www.telapi.com/docs/api/rest/connect/view/
      def get(id)
        response = Network.get(['Connect', id])
        Connect.new(response)
      end

      # Creates a connect app, returning a Telapi::Connect object
      # See http://www.telapi.com/docs/api/rest/connect/create/
      #
      # Required params:
      # +FriendlyName+:: string
      # +CompanyName+:: string
      # +HomepageUrl+:: valid URL
      # +AuthorizeUrl+:: valid URL
      # +DeauthorizeUrl+:: valid URL
      #
      # Optional params is a hash containing:
      # +LogoUrl+:: valid URL
      # +Description+:: string
      # +TosUrl+:: valid URL
      # +AuthorizeMethod+:: (POST) or GET
      # +DeauthorizeMethod+:: (POST) or GET
      # +ChargeAccountAccess+:: true or (false)
      def create(friendly_name, company_name, homepage_url, authorize_url, deauthorize_url, optional_params = {})
        opts = { :FriendlyName => friendly_name, :CompanyName => company_name, :HomepageUrl => homepage_url, :AuthorizeUrl => authorize_url, :DeauthorizeUrl => deauthorize_url }.merge(optional_params)
        response = Network.post(['Connect'], opts)
        Connect.new(response)
      end

      # Updates a connect app, returning a Telapi::Connect object
      # See http://www.telapi.com/docs/api/rest/connect/update/
      #
      # Required params:
      # +id+:: connect id
      #
      # Optional params is a hash supporting same options under ::create
      def update(id, optional_params = {})
        response = Network.post(['Connect', id], optional_params)
        Connect.new(response)
      end

      # Deletes a connect app, returning a Telapi::Connect object
      # See http://www.telapi.com/docs/api/rest/connect/delete/
      #
      # Required params:
      # +id+:: connect id
      def delete(id)
        response = Network.delete(['Connect', id])
        Connect.new(response)
      end

      # Returns a resource collection containing Telapi::User objects
      # See http://www.telapi.com/docs/api/rest/connect/list-users/
      # Required params:
      # +connect_sid+:: connect app identifier
      #
      # Optional params:
      # +AccountSid+:: true or (false)
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def users(connnect_sid, optional_params = {})
        response = Network.get(['Connect', connnect_sid, 'Users'], optional_params)
        ResourceCollection.new(response, 'connects', User)
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

        # See ::users
    def users(optional_params = {})
      self.class.users(self.sid, optional_params)
    end

  end
end
