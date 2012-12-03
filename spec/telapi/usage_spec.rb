require 'spec_helper'

describe Telapi::Usage do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "usages": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Usages exist" do
      before { stub_telapi_request('{ "usages": [{ "Product": "Carrier Lookup" }] }') }

      it "has a collection of Usage objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a Usage resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end
end
