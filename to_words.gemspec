# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'to_words/version'

Gem::Specification.new do |spec|
  spec.name          = "to_words"
  spec.version       = ToWords::VERSION
  spec.authors       = ["Taimur Akhtar"]
  spec.email         = ["taimur.akhtar@square63.com"]
  spec.summary       = %q{This would convert numbers into words.}
  spec.description   = %q{This gem would convert a number into its equivalent words(english).}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
