# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teamsupport/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'addressable', '~> 2.3'
  spec.add_dependency 'equalizer', '~> 0.0.11'
  spec.add_dependency 'http', '~> 2.0'
  spec.add_dependency 'http-form_data', '~> 1.0'
  spec.add_dependency 'naught', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.0'

  spec.name          = 'teamsupport'
  spec.version       = Teamsupport::Version
  spec.authors       = ['Jon Beilke']
  spec.email         = ['jrbeilke@gmail.com']

  spec.summary       = 'A Ruby interface to the Teamsupport API.'
  spec.description   = 'A simple library for communicating with the TeamSupport API. Currently supports Customers, Products, and Tickets, with plans to expand to full support of the API with a 1.0 release.'
  spec.homepage      = 'https://github.com/jrbeilke/teamsupport'
  spec.licenses      = %w(MIT)

  spec.files         = %w(.yardopts CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md teamsupport.gemspec) + Dir['lib/**/*.rb']
  spec.require_paths = %w(lib)
  spec.required_ruby_version = '>= 2.0.0'
end
