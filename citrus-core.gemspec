# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'citrus/core/version'

Gem::Specification.new do |gem|
  gem.name          = "citrus-core"
  gem.version       = Citrus::Core::VERSION
  gem.authors       = ["Paweł Pacana"]
  gem.email         = ["pawel.pacana@syswise.eu"]
  gem.description   = "Citrus continous integration core components."
  gem.summary       = "Citrus continous integration core components."
  gem.homepage      = "http://citrus-ci.org"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'childprocess', '~> 0.3.9'

  gem.add_development_dependency 'fakefs'
  gem.add_development_dependency 'rspec',  '~> 2.13'
  gem.add_development_dependency 'bogus',  '~> 0.1'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'mutant', '~> 0.3.0.rc3'
  gem.add_development_dependency 'coveralls', '~> 0.7'
end
