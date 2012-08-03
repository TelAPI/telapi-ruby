module Telapi
  # Wraps TelAPI Account functionality
  class Account < Resource
    class << self

      # Gets current Telapi account as a Telapi::Account object
      # See http://www.telapi.com/docs/api/rest/accounts/view/
      def get
        Account.new(Network.get)
      end

    end
  end
end
