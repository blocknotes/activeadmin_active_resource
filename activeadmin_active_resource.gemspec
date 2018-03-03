lib = File.expand_path('../lib', __FILE__)
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

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeadmin', '~> 1.0'
  spec.add_runtime_dependency 'activeresource', '~> 5.0'
end
