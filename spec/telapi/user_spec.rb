require 'spec_helper'

describe Telapi::User do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::User) }

  describe ".list" do
    it "proxies to Connect.users" do
      Telapi::Connect.should_receive(:users).with('abc123', {})
      klass.list('abc123')
    end
  end

end