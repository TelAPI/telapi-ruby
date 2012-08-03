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
      before { stub_telapi_request('{ "conferences": [{ "name": "TelAPIChat" }] }') }

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

  describe ".mute_member" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.mute_member('abc123', '123').should be_a(klass)
    end
  end

  describe "#mute_member" do
    it "proxies to Conference.mute_member" do
      klass.should_receive(:mute_member)
      klass.get('abc123').mute_member('123')
    end
  end

  describe ".unmute_member" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.unmute_member('abc123', '123').should be_a(klass)
    end
  end

  describe "#unmute_member" do
    it "proxies to Conference.unmute_member" do
      klass.should_receive(:unmute_member)
      klass.get('abc123').unmute_member('123')
    end
  end

  describe ".deaf_member" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.deaf_member('abc123', '123').should be_a(klass)
    end
  end

  describe "#deaf_member" do
    it "proxies to Conference.deaf_member" do
      klass.should_receive(:deaf_member)
      klass.get('abc123').deaf_member('123')
    end
  end

  describe ".undeaf_member" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.undeaf_member('abc123', '123').should be_a(klass)
    end
  end

  describe "#undeaf_member" do
    it "proxies to Conference.undeaf_member" do
      klass.should_receive(:undeaf_member)
      klass.get('abc123').undeaf_member('123')
    end
  end

  describe ".hangup_member" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.hangup_member('abc123', '123').should be_a(klass)
    end
  end

  describe "#hangup_member" do
    it "proxies to Conference.hangup_member" do
      klass.should_receive(:hangup_member)
      klass.get('abc123').hangup_member('123')
    end
  end

  describe ".kick_member" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.kick_member('abc123', '123').should be_a(klass)
    end
  end

  describe "#kick_member" do
    it "proxies to Conference.kick_member" do
      klass.should_receive(:kick_member)
      klass.get('abc123').kick_member('123')
    end
  end

  describe ".speak_text" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.speak_text('abc123', '123', 'hi').should be_a(klass)
    end
  end

  describe "#speak_text" do
    it "proxies to Conference.speak_text" do
      klass.should_receive(:speak_text)
      klass.get('abc123').speak_text('123', 'hi')
    end
  end

  describe ".play_audio" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.play_audio('abc123', '123', 'http://url').should be_a(klass)
    end
  end

  describe "#play_audio" do
    it "proxies to Conference.play_audio" do
      klass.should_receive(:play_audio)
      klass.get('abc123').play_audio('123', 'http://url')
    end
  end

  describe ".start_recording" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.start_recording('abc123').should be_a(klass)
    end
  end

  describe "#start_recording" do
    it "proxies to Conference.start_recording" do
      klass.should_receive(:start_recording)
      klass.get('abc123').start_recording
    end
  end

  describe ".stop_recording" do
    it "calls api via http post and returns a Conference resource" do
      api_should_use(:post)
      klass.stop_recording('abc123').should be_a(klass)
    end
  end

  describe "#stop_recording" do
    it "proxies to Conference.stop_recording" do
      klass.should_receive(:stop_recording)
      klass.get('abc123').stop_recording
    end
  end
end
