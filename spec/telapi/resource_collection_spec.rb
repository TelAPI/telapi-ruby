require 'spec_helper'

describe Telapi::ResourceCollection do
  context "when initialized with at least one nested item" do
    subject do
      klass.new({
        'page' => 0,
        'num_pages' => 0,
        'page_size' => 5,
        'total' => 1,
        'start' => 0,
        'end' => 0,
        'items' => [{ 'food' => 'burger', 'drink' => 'beer' }]
        }, 'items', Telapi::Resource)
    end

    context "setting collection-specific metrics" do
      its(:page) { should == 0 }
      its(:num_pages) { should == 0 }
      its(:page_size) { should == 5 }
      its(:total) { should == 1 }
      its(:start) { should == 0 }
      its(:end) { should == 0 }
    end

    it "has an item count greater than 0" do
      subject.items.length.should be > 0
    end

    it "is not empty" do
      subject.should_not be_empty
    end

    it "can return the last item" do
      subject.last.should be_a(Telapi::Resource)
    end

    it "can return an item using its index" do
      subject[0].should be_a(Telapi::Resource)
    end
  end

  context "when initialized without any nested items" do
    subject do
      klass.new({ 'meal' => 'dinner', 'items' => [] }, 'items', Telapi::Resource)
    end

    it "has 0 items" do
      subject.items.length.should == 0
    end

    it "is empty" do
      subject.should be_empty
    end

    it "returns nil when getting the last item" do
      subject.last.should be_nil
    end

    it "returns nil when getting a specific index" do
      subject[0].should be_nil
    end
  end
end
