require 'spec_helper'

describe Telapi::Network do
  before do
    set_account_sid_and_auth_token
    stub_telapi_request
  end

  describe ".get" do
    it "gets an api response and converts to a hash" do
      subject.get.should be_a(Hash)
    end

    context "when error is returned by the API" do
      before { stub_telapi_request_with_error_response }

      it "raises a ApiError" do
        expect { subject.get }.to raise_error(Telapi::ApiError)
      end
    end
  end

  describe ".post" do
    it "gets an api response and converts to a hash" do
      subject.post(:param1 => 'value1').should be_a(Hash)
    end

    context "when error is returned by the API" do
      before { stub_telapi_request_with_error_response }

      it "raises a ApiError" do
        expect { subject.post(:param1 => 'value1') }.to raise_error(Telapi::ApiError)
      end
    end
  end

  describe ".delete" do
    it "gets an api response and converts to a hash" do
      subject.delete.should be_a(Hash)
    end

    context "when error is returned by the API" do
      before { stub_telapi_request_with_error_response }

      it "raises a ApiError" do
        expect { subject.delete }.to raise_error(Telapi::ApiError)
      end
    end
  end

  describe ".api_uri" do
    it "generates a uri using an array of path components" do
      path_components = ['SomeResource', '123']
      subject.api_uri(path_components).should == 'https://api.telapi.com/2011-07-01/Accounts/a1b2c3/SomeResource/123.json'
    end

    context "when path components are not supplied" do
      it "generates a uri consisting of the root resource (Account)" do
        subject.api_uri.should == 'https://api.telapi.com/2011-07-01/Accounts/a1b2c3.json'
      end
    end
  end

  describe ".response_format" do
    it "is json" do
      subject.response_format.should == '.json'
    end
  end

  describe ".default_options" do
    it "raises an Invalid Configuration exception when not set properly" do
      reset_config
      expect { subject.default_options }.to raise_error(Telapi::InvalidConfiguration)
    end

    it "gets a hash of config options" do
      subject.default_options.should be_a(Hash)
    end
  end
end