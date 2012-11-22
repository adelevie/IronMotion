# -*- encoding: utf-8 -*-
require File.expand_path('../lib/iron-motion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alan deLevie"]
  gem.email         = ["adelevie@gmail.com"]
  gem.description   = %q{A RubyMotion wrapper for Iron.io's REST API}
  gem.summary       = %q{Supports basic read operations for IronWorker.}
  gem.homepage      = "http://github.com/adelevie/IronMotion"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "iron-motion"
  gem.require_paths = ["lib"]
  gem.version       = IronMotion::VERSION

  gem.add_dependency 'bubble-wrap'
  gem.add_development_dependency 'rake'
end
