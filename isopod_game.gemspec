# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'isopod_game'
  spec.version       = '0.1.0'
  spec.summary       = 'A simple text-based isopod game.'

  spec.description   = 'A fun and simple Ruby game where you play as an isopod on a mission to find certain items.'
  spec.authors       = ['Matthew Martin']
  spec.email         = ['matthew@example.com']

  spec.files         = Dir['lib/**/*.rb'] + ['isopod_game.rb']
  spec.homepage      = 'https://example.com/isopod_game'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.3.0'

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
