require 'spec_helper'

describe Telapi::Connect do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "connects": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when connect apps exist" do
      before { stub_telapi_request('{ "connects": [{ "friendly_name": "MyConnectApp" }] }') }

      it "has a collection of connect app objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a connect app resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".create" do
    it "calls api via http post and returns a connect app resource" do
      api_should_use(:post)
      klass.create('MyConnectApp', 'CompanyName', 'http://homepageurl.com', 'http://authorizeurl.com', 'http://deauthorizeurl.com').should be_a(klass)
    end
  end

  describe ".update" do
    it "calls api via http post and returns a connect app resource" do
      api_should_use(:post)
      klass.update('123', :FriendlyName => 'new name').should be_a(klass)
    end
  end

  describe "#update" do
    it "proxies to Connect.update" do
      klass.should_receive(:update)
      klass.get('abc123').update(:FriendlyName => 'another name')
    end
  end

  describe ".delete" do
    it "calls api via http delete and returns a connect app resource" do
      api_should_use(:delete)
      klass.delete('123').should be_a(klass)
    end
  end

  describe "#delete" do
    it "proxies to Connect.delete" do
      klass.should_receive(:delete)
      klass.get('abc123').delete
    end
  end

  describe ".users" do
    before { stub_telapi_request('{ "users": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.users('abc123').should be_a(Telapi::ResourceCollection)
    end

  end

  describe "#users" do
    it "proxies to Connect.users" do
      klass.should_receive(:users)
      klass.get('abc123').users
    end
  end

end