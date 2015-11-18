# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wot_xbox_api/version'

Gem::Specification.new do |spec|
  spec.name          = "wot_xbox_api"
  spec.version       = WotXboxApi::VERSION
  spec.authors       = ["Jon Calvert"]
  spec.email         = ["jonathan.calvert@kitcheck.com"]

  spec.summary       = %q{Gem for retrieving data about World of Tanks on XBOX}
  spec.description   = %q{Gem for retrieving data about World of Tanks on XBOX}
  spec.homepage      = "http://github.com/jcalvert/wot_xbox_api"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
  spec.add_dependency "json"
  spec.add_dependency "activesupport"
  spec.add_dependency "thread"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'pry'
end
