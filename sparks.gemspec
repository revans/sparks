lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/sparks/version'

Gem::Specification.new do |gem|
  gem.name          = "sparks"
  gem.version       = Sparks.version
  gem.authors       = ["Robert Evans"]
  gem.email         = ["robert@codewranglers.org"]
  gem.description   = "A lightweight framework on top of Sinatra. Can be used for applications as well as for rapid prototyping."
  gem.summary       = "A lightweight framework on top of Sinatra."
  gem.homepage      = "http://www.codewranglers.org"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest"
end
