module Telapi
  # A User is always generated via Connect but
  # this class also provides some convenience methods to access
  # them directly, thereby reducing API calls.
  class User < Resource
    class << self

      # Convenient alternative to Connect::users
      def list(connect_sid, optional_params = {})
        Connect.users(connect_sid, optional_params)
      end
    end
  end
end