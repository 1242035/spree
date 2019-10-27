# -*- encoding: utf-8 -*-
require_relative '../core/lib/viauco/core/version.rb'

Gem::Specification.new do |s|
  s.authors       = ["Ryan Bigg"]
  s.email         = ["ryan@viaucocommerce.com"]
  s.description   = %q{Viauco's API}
  s.summary       = %q{Viauco's API}
  s.homepage      = 'http://example.org'
  s.license       = 'BSD-3-Clause'

  s.required_ruby_version = '>= 2.5.0'

  s.files         = `git ls-files`.split($\).reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.name          = "viauco_api"
  s.require_paths = ["lib"]
  s.version       = Viauco.version

  s.add_development_dependency 'jsonapi-rspec'

  s.add_dependency 'viauco_core', s.version
  s.add_dependency 'rabl', '~> 0.14.1'
  s.add_dependency 'fast_jsonapi', '~> 1.5'
  s.add_dependency 'doorkeeper', '~> 5.0'
end
