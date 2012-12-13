# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bic/version'

Gem::Specification.new do |gem|
  gem.name          = "bic"
  gem.version       = Bic::VERSION
  gem.authors       = ["Pavel Lazureykis"]
  gem.email         = ["lazureykis@gmail.com"]
  gem.description   = %q{Валидация банковских реквизитов}
  gem.summary       = %q{Библиотека для валидации банковских реквизитов}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
