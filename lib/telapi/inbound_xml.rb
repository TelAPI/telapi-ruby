require 'nokogiri'

module Telapi
  # Wraps TelAPI InboundXML functionality
  # See http://www.telapi.com/docs/api/inboundxml/voice/introduction/
  class InboundXml

    # Internally Nokogiri builder is being used to construct responses.
    # See http://nokogiri.org/Nokogiri/XML/Builder.html
    #
    # Pass in a block of options:
    #
    # Telapi::InboundXml.new do
    #   Say('Hello.', :loop => 3, :voice => 'man')
    #   Say('Hello, my name is Jane.', :voice => 'woman')
    #   Say('Now I will not stop talking.', :loop => 0)
    # end
    #
    # Then calling #response produces the following output:
    #
    # <Response>
    #   <Say loop='3' voice='man'>Hello.</Say>
    #   <Say voice='woman'>Hello, my name is Jane.</Say>
    #   <Say loop='0'>Now I will not stop talking.</Say>
    # </Response>
    def initialize(&block)
      @xml = Nokogiri::XML::Builder.new
      @xml.Response &block
    end

    # Returns xml
    def response
      @xml.to_xml
    end
  end
end
