lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yq/version'

Gem::Specification.new do |spec|
  spec.name          = 'yq'
  spec.version       = Yq::VERSION
  spec.authors       = ['Jim Park']
  spec.email         = ['yq@jim80.net']
  spec.summary       = 'A JQ wrapper for YAML'
  spec.description   = "This unceremoniously shells out to a jq available in $PATH.
  Please make sure jq is installed."
  spec.homepage      = 'https://github.com/jim80net/yq'
  spec.license       = 'GPLv2'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'climate_control'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
