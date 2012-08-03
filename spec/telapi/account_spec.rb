require 'spec_helper'

describe Telapi::Account do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".get" do
    it "calls api via http get and returns an Account resource" do
      api_should_use(:get)
      klass.get.should be_a(klass)
    end
  end
end
