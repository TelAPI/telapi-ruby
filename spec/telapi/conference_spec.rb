require 'spec_helper'

describe Telapi::Conference do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "conferences": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when conferences exist" do
      before { stub_telapi_request('{ "conferences": [{ "friendly_name": "testing" }] }') }

      it "has a collection of Conference objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a Conference resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".participants" do
    before { stub_telapi_request('{ "participants": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.participants('abc123').should be_a(Telapi::ResourceCollection)
    end

    context "when Participants exist" do
      before { stub_telapi_request('{ "participants": [{ "duration": "6" }] }') }

      it "has a collection of Participant objects" do
        klass.participants('abc123').first.should be_a(Telapi::Participant)
      end
    end
  end

  describe "#participants" do
    it "proxies to Conference.participants" do
      klass.should_receive(:participants)
      klass.get('abc123').participants
    end
  end

  describe ".participant" do
    it "calls api via http get and returns a Participant" do
      api_should_use(:get)
      klass.participant('abc123', '123').should be_a(Telapi::Participant)
    end
  end

  describe "#participant" do
    it "proxies to Conference.participant" do
      klass.should_receive(:participant)
      klass.get('abc123').participant('123')
    end
  end
end
