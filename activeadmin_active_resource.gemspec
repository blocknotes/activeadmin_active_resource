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

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files         = Dir['{lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeadmin', '~> 2.0'
  spec.add_runtime_dependency 'activeresource', '>= 5.1'

  spec.add_development_dependency 'appraisal', '~> 2.4'
end
