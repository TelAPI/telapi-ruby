require 'recursive_open_struct'

module Telapi
  # Base class provides basic behavior for Telapi domain objects
  # You don't typically instantiate this class directly
  class Resource < RecursiveOpenStruct
    include Network

    def initialize(attributes={})
      super
      delete_field('subresource_uris') if respond_to?(:subresource_uris)
    end

    def attributes
      marshal_dump
    end
  end
end