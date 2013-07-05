require 'spec_helper'

describe Telapi::Message do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "mms_messages": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when MMS exist" do
      before { stub_telapi_request('{ "mms_messages": [{ "to": "+14245551234","from": "+17325551234"}] }') }

      it "has a collection of MMS objects" do
        true
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns an MMS resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".create" do
      it "calls api via http post and returns a MMS resource" do
        api_should_use(:post)
        klass.create('(111) 111-1111', '(999) 999-9999', 'My MMS message', 'https://si0.twimg.com/profile_images/2539396551/4jsroc6lvo800o81iw64.png').should be_a(klass)
      end
    end
end