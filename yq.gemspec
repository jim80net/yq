# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yq/version'

Gem::Specification.new do |spec|
  spec.name          = "yq"
  spec.version       = Yq::VERSION
  spec.authors       = ["Jim Park"]
  spec.email         = ["yq@jim80.net"]
  spec.summary       = %q{A JMESpath wrapper for YAML}
  spec.description   = ""
  spec.homepage      = "https://github.com/jim80net/yq"
  spec.license       = "GPLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.3'
  spec.add_development_dependency "pry"
end
