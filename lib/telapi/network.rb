require 'httparty'

module Telapi
  # Internal object for network operations; wraps HTTParty
  module Network #:nodoc:
    include HTTParty

    class << self
      def get(path_components=[], query=nil)
        options = default_options.merge(:query => query)
        handle_response(HTTParty.get api_uri(path_components), options)
      end

      def post(path_components=[], body)
        options = default_options.merge(:body => body)
        handle_response(HTTParty.post api_uri(path_components), options)
      end

      def delete(path_components=[])
        handle_response(HTTParty.delete api_uri(path_components), default_options)
      end

      # path_components is an array of uri fragments, e.g ['Calls', '1234abc']
      def api_uri(path_components=[])
        [ Telapi.config.base_uri, 'Accounts', Telapi.config.account_sid, path_components ].flatten.join('/') + response_format
      end

      def response_format
        @api_format ||= '.json'
      end

      def default_options
        {
          :basic_auth => {
            :username => (Telapi.config.account_sid || raise(InvalidConfiguration, 'account_sid')),
            :password => (Telapi.config.auth_token  || raise(InvalidConfiguration, 'auth_token'))
          },
          :ssl_ca_path => Telapi.config.ssl_ca_path
        }
      end

      private

      def handle_response(response)
        raise Telapi::ApiError.new(response.parsed_response) unless response.success?
        response
      end
    end
  end
end