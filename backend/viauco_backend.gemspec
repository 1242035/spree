# encoding: UTF-8
require_relative '../core/lib/viauco/core/version.rb'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'viauco_backend'
  s.version     = Viauco.version
  s.summary     = 'backend e-commerce functionality for the Viauco project.'
  s.description = 'Required dependency for Viauco'

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
  s.add_dependency 'jquery-rails',    '~> 4.3'
  s.add_dependency 'jquery-ui-rails', '~> 6.0.1'
  s.add_dependency 'select2-rails',   '3.5.9.1' # 3.5.9.2 breaks several specs
end
