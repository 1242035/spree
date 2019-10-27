# encoding: UTF-8
require_relative '../core/lib/viauco/core/version.rb'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'viauco_sample'
  s.version     = Viauco.version
  s.summary     = 'Sample data (including images) for use with Viauco.'
  s.description = 'Required dependency for Viauco'

  s.author      = 'Author'
  s.email       = 'author@example.com'
  s.homepage    = 'http://example.org'
  s.license     = 'BSD-3-Clause'

  s.files        = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'viauco_core', s.version
end
