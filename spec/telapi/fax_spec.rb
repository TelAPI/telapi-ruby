require 'spec_helper'

describe Telapi::Fax do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "faxes": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Faxes exist" do
      before { stub_telapi_request('{ "faxes": [{ "from": "+14245551234","to": "+17325551234"}] }') }

      it "has a collection of Fax objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a Fax resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".create" do
    it "calls api via http post and returns a Fax resource" do
      api_should_use(:post)
      klass.create('(111) 111-1111', '(999) 999-9999', 'http://telapi.com/documents/cloud-fax.tiff').should be_a(klass)
    end
  end
end
