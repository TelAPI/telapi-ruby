require 'spec_helper'

describe Telapi::AvailablePhoneNumber do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "available_phone_numbers": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list('US').should be_a(Telapi::ResourceCollection)
    end

    context "when Available Phone Numbers exist" do
      before { stub_telapi_request('{ "available_phone_numbers": [{ "phone_number": "+14242495526" }] }') }

      it "has a collection of Available Phone Number objects" do
        klass.list('US').first.should be_a(klass)
      end
    end
  end
end