require 'spec_helper'

describe Telapi::Participant do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Participant) }

  describe ".list" do
    it "proxies to Conference.participants" do
      Telapi::Conference.should_receive(:participants).with('abc123', {})
      klass.list('abc123')
    end
  end

  describe ".get" do
    it "proxies to Conference.participant" do
      Telapi::Conference.should_receive(:participant).with('abc123', '123')
      klass.get('abc123', '123')
    end
  end

  let(:participant) { klass.get('abc123', '123') }

  describe "#deaf" do
    it "calls api via http post and returns a Participant resource" do
      api_should_use(:post)
      participant.deaf.should be_a(klass)
    end
  end

  describe "#undeaf" do
    it "calls api via http post and returns a Participant resource" do
      api_should_use(:post)
      participant.undeaf.should be_a(klass)
    end
  end

  describe "#mute" do
    it "calls api via http post and returns a Participant resource" do
      api_should_use(:post)
      participant.mute.should be_a(klass)
    end
  end

  describe "#unmute" do
    it "calls api via http post and returns a Participant resource" do
      api_should_use(:post)
      participant.unmute.should be_a(klass)
    end
  end

  describe "#hangup" do
    it "calls api via http delete and returns a Participant resource" do
      api_should_use(:delete)
      participant.hangup.should be_a(klass)
    end
  end

  describe "#play_audio" do
    it "calls api via http post and returns a Participant resource" do
      api_should_use(:post)
      participant.play_audio('http://url').should be_a(klass)
    end
  end
end