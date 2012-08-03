require 'spec_helper'

describe Telapi::Transcription do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "transcriptions": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Transcriptions exist" do
      before { stub_telapi_request('{ "transcriptions": [{ "transcription_text": "foo" }] }') }

      it "has a collection of Transcription objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a Transcription resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".transcribe_audio" do
    it "calls api via http post and returns a Transcription resource" do
      api_should_use(:post)
      klass.transcribe_audio('http://audio-url').should be_a(klass)
    end
  end
end