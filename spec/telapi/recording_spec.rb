require 'spec_helper'

describe Telapi::Recording do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "recordings": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Recordings exist" do
      before { stub_telapi_request('{ "recordings": [{ "duration": "6" }] }') }

      it "has a collection of Recording objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a Recording resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".transcribe" do
    it "calls api via http post and returns a Transcription resource" do
      api_should_use(:post)
      klass.transcribe('abc123').should be_a(Telapi::Transcription)
    end
  end

  describe "#transcribe" do
    it "proxies to Recording.transcribe" do
      klass.should_receive(:transcribe)
      klass.get('abc123').transcribe
    end
  end

  describe ".transcriptions" do
    before { stub_telapi_request('{ "transcriptions": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.transcriptions('abc123').should be_a(Telapi::ResourceCollection)
    end

    context "when Transcriptions exist" do
      before { stub_telapi_request('{ "transcriptions": [{ "transcription_text": "foo" }] }') }

      it "has a collection of Transcription objects" do
        klass.transcriptions('abc123').first.should be_a(Telapi::Transcription)
      end
    end
  end

  describe "#transcriptions" do
    it "proxies to Recording.transcriptions" do
      klass.should_receive(:transcriptions)
      klass.get('abc123').transcriptions
    end
  end
end