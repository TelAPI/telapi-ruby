module Telapi
  class ApiError < StandardError
    attr_accessor :status, :code, :help_uri

    def initialize(attributes)
      super attributes['message']
      @status = attributes['status']
      @code = attributes['code']
      @help_uri = attributes['more_info']
    end
  end

  class InvalidConfiguration < StandardError
    def initialize(attribute)
      @attribute = attribute
    end

    def message
      "The following configuration setting is not properly set: #{@attribute}"
    end
  end
end