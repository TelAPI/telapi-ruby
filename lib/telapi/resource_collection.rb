require 'forwardable'

module Telapi
  # This class wraps Resource objects and provides Enumerable functionality.
  #
  # Note that TelAPI collections are automatically separated into pages of results,
  # see http://www.telapi.com/docs/api/rest/overview/response/.
  #
  # Currently this container class does not automatically handle the retrieving of
  # a previous/next page of results. However, all of the Resource classes that provide
  # a +list+ method allow you to specify the current page and size.
  class ResourceCollection
    include Enumerable
    extend Forwardable

    attr_reader :items, :page, :num_pages, :page_size, :total, :start, :end

    def initialize(attributes, collection_node_name, resource_type)
      @page      = attributes['page']
      @num_pages = attributes['num_pages']
      @page_size = attributes['page_size']
      @total     = attributes['total']
      @start     = attributes['start']
      @end       = attributes['end']
      @items     = []

      attributes[collection_node_name].each do |item|
        @items << resource_type.send(:new, item)
      end if attributes[collection_node_name]
    end

    def_delegators :@items, :[], :empty?, :last

    def each
      @items.each { |i| yield i }
    end
  end
end