# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'idtbeyond/version'

Gem::Specification.new do |spec|
  spec.name          = "IDTBeyond"
  spec.version       = IDTBeyond::VERSION
  spec.authors       = ["Robbie Holmes"]
  spec.email         = ["robbiethegeek@gmail.com"]
  spec.summary       = %q{The gem for interacting with the IDTBeyond API.}
  spec.description   = %q{This gem will allow developers to interact with the IDTBeyond API for all published services.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
