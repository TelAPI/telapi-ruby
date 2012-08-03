require 'spec_helper'

describe Telapi::Fraud do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "frauds": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Fraud controls exist" do
      before { stub_telapi_request('{ "frauds": [{ "key": "value" }] }') }

      it "has a collection of Fraud objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".authorize" do
    it "calls api via http post and returns a Fraud resource" do
      api_should_use(:post)
      klass.authorize('US').should be_a(klass)
    end
  end

  describe ".extend_authorization" do
    it "calls api via http post and returns a Fraud resource" do
      api_should_use(:post)
      klass.extend_authorization('US').should be_a(klass)
    end
  end

  describe ".block" do
    it "calls api via http post and returns a Fraud resource" do
      api_should_use(:post)
      klass.block('US').should be_a(klass)
    end
  end

  describe ".whitelist" do
    it "calls api via http post and returns a Fraud resource" do
      api_should_use(:post)
      klass.whitelist('US').should be_a(klass)
    end
  end
end