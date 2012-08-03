module TelapiHelpers #:nodoc:
  def klass
    described_class
  end

  def stub_telapi_request(body = '{"sid": "a1b2c3"}', opts={})
    options = {:body => body, :content_type => "application/json"}.merge(opts)
    FakeWeb.register_uri(:any, /.*telapi.com.*/, options)
  end

  def stub_telapi_request_with_error_response
    stub_telapi_request(
      '{"status": 403,
        "message": "Invalid credentials supplied",
        "code": 10004,
        "more_info": "http://www.telapi.com/docs/api/rest/overview/errors/10004"}',
      :status => 400
    )
  end

  def set_account_sid_and_auth_token
    Telapi.config do |config|
      config.account_sid = 'a1b2c3'
      config.auth_token  = 'x5y6z7'
    end
  end

  def reset_config
    Telapi.config do |config|
      config.account_sid = nil
      config.auth_token  = nil
    end
  end

  def api_should_use(verb_symbol, response={})
    Telapi::Network.should_receive(verb_symbol).and_return(response)
  end
end
