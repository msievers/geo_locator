# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geo_locator/version'

Gem::Specification.new do |spec|
  spec.name          = "geo_locator"
  spec.version       = GeoLocator::VERSION
  spec.authors       = ["Michael Sievers"]
  spec.email         = ["michael_sievers@web.de"]
  spec.summary       = %q{A ruby gem for translating geo informations (e.g. zip code) to geo locations.}
  spec.homepage      = "https://github.com/msievers/geo_locator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",               "~> 1.5"
  spec.add_development_dependency "pry",                   "~> 0.9.12.4"
  spec.add_development_dependency "pry-nav",               "~> 0.2.3"
  spec.add_development_dependency "pry-stack_explorer",    "~> 0.4.9.1"
  spec.add_development_dependency "pry-syntax-hacks",      "~> 0.0.6"
  spec.add_development_dependency "rspec",                 "~> 2.14.1"
  spec.add_development_dependency "rake"
end
