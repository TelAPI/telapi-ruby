require 'spec_helper'

# to avoid retesting the Nokogiri gem, our specs are minimal
describe Telapi::InboundXml do
  describe "#reponse" do
    it "returns XML wrapped in a Response node" do

      ix = klass.new do
        Say('Hello.', :loop => 3, :voice => 'man')
        Say('Hello, my name is Jane.', :voice => 'woman')
        Say('Now I will not stop talking.', :loop => 0)
      end

      expected = <<-END.gsub(/^ {6}/, '')
      <?xml version="1.0"?>
      <Response>
        <Say loop="3" voice="man">Hello.</Say>
        <Say voice="woman">Hello, my name is Jane.</Say>
        <Say loop="0">Now I will not stop talking.</Say>
      </Response>
      END

      ix.response.should == expected
    end

    it "handles nested blocks correctly" do

      ix = klass.new do
        Gather(:action      => 'http://example.com/example-callback-url/say?example=simple.xml',
               :method      => 'GET',
               :numDigits   => '4',
               :finishOnKey => '#') {
          Say 'Please enter your 4 digit pin.'
        }
      end

      expected = <<-END.gsub(/^ {6}/, '')
      <?xml version="1.0"?>
      <Response>
        <Gather action="http://example.com/example-callback-url/say?example=simple.xml" method="GET" numDigits="4" finishOnKey="#">
          <Say>Please enter your 4 digit pin.</Say>
        </Gather>
      </Response>
      END

      ix.response.should == expected
    end
  end
end