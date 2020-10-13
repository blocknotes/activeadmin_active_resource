# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin/active_resource/version'

Gem::Specification.new do |spec|
  spec.name          = 'activeadmin_active_resource'
  spec.version       = ActiveAdmin::ActiveResource::VERSION
  spec.summary       = 'Active Resource for ActiveAdmin'
  spec.description   = 'An Active Admin plugin to use Active Resource'
  spec.license       = 'MIT'
  spec.authors       = ['Mattia Roccoberton']
  spec.email         = 'mat@blocknot.es'
  spec.homepage      = 'https://github.com/blocknotes/activeadmin_active_resource'

  spec.files         = Dir['{lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeadmin', '~> 2.0'
  spec.add_runtime_dependency 'activeresource', '~> 5.1.1'

  spec.add_development_dependency 'activestorage', '~> 6.0.3.2'
  spec.add_development_dependency 'capybara', '~> 3.33.0'
  spec.add_development_dependency 'pry', '~> 0.13.1'
  spec.add_development_dependency 'puma', '~> 4.3.5'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'rspec-rails', '~> 4.0.1'
  spec.add_development_dependency 'rubocop', '~> 0.90.0'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.142.7'
  spec.add_development_dependency 'sqlite3', '~> 1.4.2'
  spec.add_development_dependency 'vcr', '~> 6.0.0'
  spec.add_development_dependency 'webmock', '~> 3.9.2'
end
