require 'spec_helper'

describe Telapi::Message do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

describe ".create" do
    it "calls api via http post and returns a MMS resource" do
      api_should_use(:post)
      klass.create('(111) 111-1111', '(999) 999-9999', 'My MMS message', 'https://si0.twimg.com/profile_images/2539396551/4jsroc6lvo800o81iw64.png').should be_a(klass)
    end
  end
end