# encoding: UTF-8
require_relative 'core/lib/viauco/core/version.rb'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'viauco'
  s.version     = Viauco.version
  s.summary     = 'Full-stack e-commerce framework for Ruby on Rails.'
  s.description = 'Viauco is an open source e-commerce framework for Ruby on Rails.'

  s.required_ruby_version = '>= 2.5.0'

  s.files        = Dir['README.md', 'lib/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.author       = 'Author'
  s.email        = 'author@abc.com'
  s.homepage     = 'http://abc.org'
  s.license      = 'BSD-3-Clause'

  s.add_dependency 'viauco_core', s.version
  s.add_dependency 'viauco_api', s.version
  s.add_dependency 'viauco_backend', s.version
  s.add_dependency 'viauco_frontend', s.version
  s.add_dependency 'viauco_sample', s.version
  s.add_dependency 'viauco_cmd', s.version
end
