# -*- encoding: utf-8 -*-

require File.expand_path('../lib/podcast_reader', __FILE__)

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

  gem.add_development_dependency 'bundler', '~> 1.0'
end
