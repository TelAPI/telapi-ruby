# TelAPI Ruby Gem

See www.telapi.com to signup for TelAPI.

**PLEASE NOTE THAT THIS LIBRARY IS NOT ACTIVELY MAINTAINED BY TELAPI**

## Installation

Add this line to your application's Gemfile:

    gem 'telapi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telapi

## Authentication and Configuration

Every API request requires a valid *account_sid* and *auth_token*. By default these are set to *nil*, so your application
should set them in its configuration (e.g. Ruby on Rails initializer).

For example:

    Telapi.config do |config|
      config.account_sid = 'abc123'
      config.auth_token  = 'xyz567'
    end

You can also set individual settings directly:

    Telapi.config.ssl_ca_path = '/some/path'

Inspecting the current configuration returns a hash:

    p Telapi.config # (or Telapi.config.inspect)
    #=> {:base_uri=>"https://api.telapi.com/2011-07-01/", :ssl_ca_path=>"/some/path", :account_sid=>'abc123', :auth_token=>'xyz567'}

## Design

Minimal code is needed to retrieve objects and perform operations. There's no need to instantiate a client object -- work directly with the desired classes.

Most classes provide identically named class and instance methods for ultimate flexibility. For example, to hang up an existing call, you can call either of the following:

    call = Telapi::Call.get('123abc')
    call.hangup

    # avoids an additional network request
    Telapi::Call.hangup('123abc')

Individual objects are wrapped into a Resource instance, which exposes all of the attributes documented in the [TelAPI documentation](http://www.telapi.com/docs/) as accessors and avoids the need to deal with direct JSON responses in your application code. A convenient *attributes* method allows you to dump out the object's values.

    Telapi::Account.get.attributes
    # => { ...hash of keys and values... }

Methods that return collections wrap Resource objects in a Resource Collection instance, which behaves similar to an Array, but also includes meta info about totals, page size, current page, etc.

## Documentation

Detailed documentation for this libray can be found at [TelAPI-Ruby Reference](http://telapi.github.com/telapi-ruby/) or [RubyDoc](http://rubydoc.info/gems/telapi/).

## Usage Examples - REST API

Refer to the documentation for more examples.

### Get account details

    acct = Telapi::Account.get
    acct.friendly_name    # => "My Account"
    acct.account_balance  # => "25.000"

### Get available numbers

    numbers = Telapi::AvailablePhoneNumber.list('US', :AreaCode => '805')
    numbers.each { |n| puts n.phone_number }
    # => +18052585701
    #    +18052585702

### Get list of calls

    Telapi::Call.list # => returns ResouceCollection of Telapi::Call objects

### Make a call

    Telapi::Call.make('12223334444', '13334445555', 'http://mycallback...')

### Record a call

    call = Telapi::Call.get('123abc')
    call.record

    # or invoke the class method to avoid an additional network request
    Telapi::Call.record('123abc')

### Send an SMS message
    # Telapi::Message.create('To', 'From', 'Body', 'Status Callback')
    Telapi::Message.create('12223334444', '13334445555', 'Check out TelAPI!')

### Send an MMS
    # Telapi::MMS.create('To', 'From', 'Body', 'Attachment URL', 'Status Callback')
    Telapi::MMS.create('12223334444', '13334445555', 'Check out TelAPI!', 'http://telapi.com/some-image-url.png')

### Transcribe audio

    Telapi::Transcription.transcribe_audio('http://some-audio-url')

### Caller ID

    Telapi::CallerId.lookup('12223334444')

## Usage Examples - Inbound XML

### Say

    ix = Telapi::InboundXml.new do
      Say('Hello.', :loop => 3, :voice => 'man')
      Say('Hello, my name is Jane.', :voice => 'woman')
      Say('Now I will not stop talking.', :loop => 0)
    end

    ix.response

    # results in the following XML:
    # <?xml version="1.0"?>
    # <Response>
    #   <Say loop="3" voice="man">Hello.</Say>
    #   <Say voice="woman">Hello, my name is Jane.</Say>
    #   <Say loop="0">Now I will not stop talking.</Say>
    # </Response>

### Play

    Telapi::InboundXml.new { Play('http://example.com/hello.mp3', :loop => 3) }

### Gather

    Telapi::InboundXml.new do
      Gather(:action      => 'http://example.com/example-callback-url/say?example=simple.xml',
             :method      => 'GET',
             :numDigits   => '4',
             :finishOnKey => '#') {
        Say 'Please enter your 4 digit pin.'
      }
    end

### SMS Response

    Telapi::InboundXml.new do
      Sms(
        'Test message sent from TelAPI!',
        :action => 'http://liveoutput.com/telapi-test-sms-action',
        :method => 'POST',
        :from => '1112223333',
        :to => '3334445555',
        :statusCallback => 'http://liveoutput.com/telapi-test-status-callback'
      )
    end

## Compatibility

Currently targeted for Ruby 1.9.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
