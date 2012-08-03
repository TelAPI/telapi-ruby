# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telapi/version'

Gem::Specification.new do |gem|
  gem.name          = "telapi"
  gem.version       = Telapi::VERSION
  gem.authors       = ["Phil Misiowiec"]
  gem.email         = ["phil@webficient.com"]
  gem.description   = %q{TelAPI wrapper. See www.telapi.com.}
  gem.summary       = %q{TelAPI wrapper}
  gem.homepage      = "http://github.com/telapi/telapi-ruby"

  gem.rubyforge_project = "telapi-ruby"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httparty', '>= 0.8.3'
  gem.add_dependency 'multi_json', '>= 1.3.6'
  gem.add_dependency 'nokogiri',   '>= 1.5.5'
  gem.add_dependency 'recursive-open-struct', '>= 0.2.1'

  gem.add_development_dependency 'rake',  '~> 0.9.0'
  gem.add_development_dependency 'rspec', '~> 2.11'
  gem.add_development_dependency 'fakeweb', '>= 1.3.0'

  gem.extra_rdoc_files = ['LICENSE']
end
