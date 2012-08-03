require 'spec_helper'

describe "Configuration" do
  subject { Telapi.config }

  context "getting config options" do
    it "has retrievable options" do
      subject.ssl_ca_path.should be
    end

    it "returns nil for unknown options" do
      subject.blah.should be_nil
    end
  end

  context "setting config options" do
    it "can be set individually" do
      subject.ssl_ca_path = '/foo/bar'
      subject.ssl_ca_path.should == '/foo/bar'
    end

    it "can be set with a block" do
      Telapi.config do |config|
        config.ssl_ca_path = '/something/else'
      end

      subject.ssl_ca_path.should == '/something/else'
    end
  end

  context "inspection" do
    %w(to_s inspect).each do |method|
      it "returns a hash of options via #{method}" do
        subject.send(method.to_sym).should be_a(Hash)
      end
    end
  end
end