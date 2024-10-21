# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'helios_auth/version'

Gem::Specification.new do |spec|
  spec.name          = 'helios-auth'
  spec.version       = HeliosAuth::VERSION
  spec.authors       = ['Your Name']
  spec.email         = ['your.email@example.com']

  spec.summary       = 'Short summary of your gem'
  spec.description   = 'Longer description of your gem'
  spec.homepage      = 'https://github.com/bookingsync/helios-auth'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 5.0'
  spec.add_dependency 'doorkeeper', '~> 5.6.9'
  spec.add_dependency 'rails', '>= 6.0'
  spec.add_dependency 'railties', '>= 5.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
