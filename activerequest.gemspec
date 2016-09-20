# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_request/version'

Gem::Specification.new do |spec|
  spec.name          = "activerequest"
  spec.version       = ActiveRequest::VERSION
  spec.authors       = ["Alexandre Tavares"]
  spec.email         = ["xptavares@gmail.com"]

  spec.summary       = %q{Like ActiveRecord but from request}
  spec.description   = %q{Like ActiveRecord but from request}
  spec.homepage      = "http://rubygems.org/gems/activerequest"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "activesupport", '>= 4.2.7'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'mocha', '~> 1.1'
  spec.add_development_dependency "minitest-vcr", "~> 1.4.0"
end
