require 'spec_helper'

describe Telapi::IncomingPhoneNumber do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "incoming_phone_numbers": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Incoming Phone Numbers exist" do
      before { stub_telapi_request('{ "incoming_phone_numbers": [{ "phone_number": "+14242495526" }] }') }

      it "has a collection of Incoming Phone Number objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a IncomingPhoneNumber resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".create" do
    it "calls api via http post and returns an IncomingPhoneNumber resource" do
      api_should_use(:post)
      klass.create('14155551234').should be_a(klass)
    end
  end

  describe ".delete" do
    it "calls api via http delete and returns an IncomingPhoneNumber resource" do
      api_should_use(:delete)
      klass.delete('123').should be_a(klass)
    end
  end

  describe "#delete" do
    it "proxies to IncomingPhoneNumber.speak_text" do
      klass.should_receive(:delete)
      klass.get('abc123').delete
    end
  end

  describe ".update" do
    it "calls api via http post and returns an IncomingPhoneNumber resource" do
      api_should_use(:post)
      klass.update('123', :FriendlyName => 'new name').should be_a(klass)
    end
  end

  describe "#update" do
    it "proxies to IncomingPhoneNumber.update" do
      klass.should_receive(:update)
      klass.get('abc123').update(:FriendlyName => 'new name')
    end
  end
end