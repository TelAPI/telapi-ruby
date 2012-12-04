require 'spec_helper'

describe Telapi::Bna do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".lookup" do
    it "calls api via http get and returns a BNA resource" do
      api_should_use(:get)
      klass.lookup('17325551234').should be_a(klass)
    end
  end
end