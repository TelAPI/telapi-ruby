require 'spec_helper'

describe Telapi::ApiError do
  subject do
    Telapi::ApiError.new(
      'status' => 403,
      'message' => 'Invalid credentials supplied',
      'code' => 10004,
      'more_info' => 'http://www.telapi.com/docs/api/rest/overview/errors/10004'
    )
  end

  it "has a status" do
    subject.status.should == 403
  end

  it "has a code" do
    subject.code.should == 10004
  end

  it "has a help uri" do
    subject.help_uri.should == 'http://www.telapi.com/docs/api/rest/overview/errors/10004'
  end
end

describe Telapi::InvalidConfiguration do
  subject { Telapi::InvalidConfiguration.new('attribute name') }

  it "has a message containing the attribute" do
    subject.message.should include('attribute name')
  end
end
