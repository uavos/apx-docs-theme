

THEME_NAME := apx-docs-theme

GIT_VERSION = $(shell git describe --tags --match="v*.*" 2> /dev/null |sed 's/^v//;s/\-/\./;s/\(.*\)-\(.*\)/\1/')

release: gem
	gem build $(THEME_NAME).gemspec
	gem push $(THEME_NAME)-*.gem


gem:
	gem build $(THEME_NAME).gemspec



.PHONY: FORCE

VERSION:
	@echo "Current version: $(call GIT_VERSION)"
	@echo $(call GIT_VERSION) > $@
