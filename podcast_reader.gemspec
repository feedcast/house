# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "podcast_reader/version"

Gem::Specification.new do |gem|
  gem.name          = "podcast_reader"
  gem.version       = PodcastReader::VERSION
  gem.summary       = %q{A example gem for reading podcast rss feeds}
  gem.description   = %q{A example gem for reading podcast rss feeds}
  gem.license       = "MIT"
  gem.authors       = ["Luke Pearce"]
  gem.email         = "podcast_reader@kulesolutions.com"
  gem.homepage      = "https://github.com/kule/podcast_reader#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency "nokogiri"
  gem.add_dependency "open_uri_redirections"

  gem.add_development_dependency "bundler", "~> 1.0"
  gem.add_development_dependency "rake", "~> 0.9.2"
  gem.add_development_dependency "rspec", "~> 2.4"
  gem.add_development_dependency "sham_rack", "~> 1.3"
  gem.add_development_dependency "sinatra"
end
