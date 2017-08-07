.PHONY: default
default: setup

.PHONY: setup
setup:
	bundle install

.PHONY: spec
spec:
	bundle exec rspec

.PHONY: test
test: spec

.PHONY: install
install:
	bundle exec rake install

.PHONY: release
release:
	bundle exec rake release
