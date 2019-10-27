# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require_relative '../core/lib/viauco/core/version.rb'

Gem::Specification.new do |s|
  s.name        = "viauco_cmd"
  s.version     = Viauco.version
  s.authors     = ['Chris Mar']
  s.email       = ['chris@viaucocommerce.com']
  s.homepage    = 'http://example.org'
  s.license     = 'BSD-3-Clause'
  s.summary     = 'Viauco Commerce command line utility'
  s.description = 'tools to create new Viauco stores and extensions'

  s.files         = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.bindir        = 'bin'
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec'
  # Temporary hack until https://github.com/wycats/thor/issues/234 is fixed
  s.add_dependency 'thor', '~> 0.14'
end
