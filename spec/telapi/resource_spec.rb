require 'spec_helper'

describe Telapi::Resource do
  let(:initial_hash) { Hash['foo' => 'bar', 'nested' => { 'item' => 'one' }] }

  context "when initialized using a hash" do
    subject { klass.new(initial_hash) }

    it "has methods named identically to the initial hash keys" do
      subject.foo.should == 'bar'
    end

    it "handles nested attributes properly" do
      subject.nested.item.should == 'one'
    end

    it "returns nil for an unknown method" do
      subject.blah.should be_nil
    end

    it "can return hash of attributes" do
      subject.attributes.should be_a(Hash)
    end
  end
end
