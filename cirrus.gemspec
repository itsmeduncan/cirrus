# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cirrus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Duncan Grazier"]
  gem.email         = ["itsmeduncan@gmail.com"]
  gem.description   = %q{Transactional-like locking for your blocks of code}
  gem.summary       = %q{A simple tool that leverages Redis to allow you to safetly lock your blocks of code}
  gem.homepage      = "https://github.com/itsmeduncan/cirrus"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.name          = "cirrus"
  gem.require_paths = ["lib"]
  gem.version       = Cirrus::VERSION

  gem.add_development_dependency("minitest",  "~> 3.3.0")

  gem.add_dependency("redis", "~> 3.0.1")
end
