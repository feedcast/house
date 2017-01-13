# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "house/version"

Gem::Specification.new do |gem|
  gem.name          = "house.rb"
  gem.version       = House::VERSION
  gem.summary       = %q{Podcast Reader and Diagnostician}
  gem.description   = %q{Podcast RSS Reader and Diagnostician}
  gem.license       = "APACHE"
  gem.authors       = ["Marcelo Boeira"]
  gem.email         = "me@marceloboeira.com"
  gem.homepage      = "https://github.com/feedcast/house"

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  gem.require_paths = ["lib"]

  gem.add_dependency "nokogiri"
  gem.add_dependency "open_uri_redirections"

  gem.add_development_dependency "bundler", "~> 1.0"
  gem.add_development_dependency "rake", "~> 0.9.2"
  gem.add_development_dependency "rspec", "~> 2.4"
  gem.add_development_dependency "sham_rack", "~> 1.3"
  gem.add_development_dependency "sinatra"
end
