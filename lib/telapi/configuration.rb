require 'ostruct'

module Telapi
  class Configuration < OpenStruct #:nodoc:
    def initialize
      super(
        :base_uri    => 'https://api.telapi.com/2011-07-01',
        :ssl_ca_path => '/etc/ssl/certs',
        :account_sid => nil,
        :auth_token  => nil
      )
    end

    def inspect
      marshal_dump
    end
    alias_method :to_s, :inspect
  end

  # Change the default Telapi configuration by setting an individual key or passing in a configuration block.
  #
  #   # set individual keys
  #   Telapi.config.ssl_ca_path = '/some/path'
  #
  #   # or use a block
  #   Telapi.config do |config|
  #     config.ssl_ca_path = '/some/path'
  #     config.account_sid = 'abc123'
  #     config.auth_token  = 'xyz567'
  #   end
  #
  # To get the current configuration as a hash:
  #
  #   p Telapi.config
  #   # => {:base_uri=>"https://api.telapi.com/2011-07-01/", :ssl_ca_path=>"/etc/ssl/certs", :account_sid=>"abc123", :auth_token=>"xyz567"}
  def self.config
    @config ||= Configuration.new
    block_given? ? yield(@config) : @config
  end
end
