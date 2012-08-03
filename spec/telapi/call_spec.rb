require 'spec_helper'

describe Telapi::Call do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "calls": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Calls exist" do
      before { stub_telapi_request('{ "calls": [{ "from": "+14245551234","to": "+17325551234"}] }') }

      it "has a collection of Call objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".get" do
    it "calls api via http get and returns a Call resource" do
      api_should_use(:get)
      klass.get('abc123').should be_a(klass)
    end
  end

  describe ".make" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.make('(111) 111-1111', '(999) 999-9999', 'http://www.telapi.com/ivr/welcome/call').should be_a(klass)
    end
  end

  describe ".interrupt" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.interrupt('abc123', 'http://www.telapi.com/ivr/welcome/call').should be_a(klass)
    end
  end

  describe "#interrupt" do
    it "proxies to Call.interrupt" do
      klass.should_receive(:interrupt)
      klass.get('abc123').interrupt('http://www.telapi.com/ivr/welcome/call')
    end
  end

  describe ".hangup" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.hangup('abc123').should be_a(klass)
    end
  end

  describe "#hangup" do
    it "proxies to Call.hangup" do
      klass.should_receive(:hangup)
      klass.get('abc123').hangup
    end
  end

  describe ".send_digits" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.send_digits('abc123', '12ww34').should be_a(klass)
    end
  end

  describe "#send_digits" do
    it "proxies to Call.send_digits" do
      klass.should_receive(:send_digits)
      klass.get('abc123').send_digits('12ww34')
    end
  end

  describe ".play_audio" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.play_audio('abc123', 'http://www.telapi.com/ivr/welcome/call').should be_a(klass)
    end
  end

  describe "#play_audio" do
    it "proxies to Call.play_audio" do
      klass.should_receive(:play_audio)
      klass.get('abc123').play_audio('http://www.telapi.com/ivr/welcome/call')
    end
  end

  describe ".voice_effect" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.voice_effect('abc123').should be_a(klass)
    end
  end

  describe "#voice_effect" do
    it "proxies to Call.voice_effect" do
      klass.should_receive(:voice_effect)
      klass.get('abc123').voice_effect(:Pitch => '-1')
    end
  end

  describe ".record" do
    it "calls api via http post and returns a Call resource" do
      api_should_use(:post)
      klass.record('abc123').should be_a(klass)
    end
  end

  describe "#record" do
    it "proxies to Call.record" do
      klass.should_receive(:record)
      klass.get('abc123').record
    end
  end

  describe ".recordings" do
    before { stub_telapi_request('{ "recordings": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.recordings('abc123').should be_a(Telapi::ResourceCollection)
    end

    context "when Recordings exist" do
      before { stub_telapi_request('{ "recordings": [{ "duration": "6" }] }') }

      it "has a collection of Recording objects" do
        klass.recordings('abc123').first.should be_a(Telapi::Recording)
      end
    end
  end

  describe "#recordings" do
    it "proxies to Call.recordings" do
      klass.should_receive(:recordings)
      klass.get('abc123').recordings
    end
  end

  describe ".notifications" do
    before { stub_telapi_request('{ "notifications": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.notifications('abc123').should be_a(Telapi::ResourceCollection)
    end

    context "when Notifications exist" do
      before { stub_telapi_request('{ "notifications": [{ "message_text": "foo" }] }') }

      it "has a collection of Notification objects" do
        klass.notifications('abc123').first.should be_a(Telapi::Notification)
      end
    end
  end

  describe "#notifications" do
    it "proxies to Call.notifications" do
      klass.should_receive(:notifications)
      klass.get('abc123').notifications
    end
  end
end
