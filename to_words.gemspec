# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "to_words/version"

Gem::Specification.new do |spec|
  spec.name          = "to_words"
  spec.version       = ToWords::VERSION
  spec.authors       = ["Taimur Akhtar"]
  spec.email         = ["taimur.akhtar@square63.com"]
  spec.summary       = "This would convert numbers into words."
  spec.description   = "This gem would convert a number into its equivalent"\
  " words(english)."
  spec.homepage      = "https://github.com/taimur-akhtar/to_words"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
