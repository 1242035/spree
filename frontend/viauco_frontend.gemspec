# encoding: UTF-8
require_relative '../core/lib/viauco/core/version.rb'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'viauco_frontend'
  s.version     = Viauco.version
  s.summary     = 'Frontend e-commerce functionality for the Viauco project.'
  s.description = s.summary

  s.required_ruby_version = '>= 2.5.0'

  s.author      = 'Author'
  s.email       = 'author@example.com'
  s.homepage    = 'http://example.org'
  s.license     = 'BSD-3-Clause'

  s.files        = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'viauco_api', s.version
  s.add_dependency 'viauco_core', s.version

  s.add_dependency 'bootstrap',       '~> 4.3.1'
  s.add_dependency 'glyphicons',      '~> 1.0.2'
  s.add_dependency 'canonical-rails', '~> 0.2.5'
  s.add_dependency 'jquery-rails',    '~> 4.3'

  s.add_development_dependency 'capybara-accessible'
end
