

THEME_NAME := apx-docs-theme

GIT_VERSION = $(shell git describe --tags --match="v*.*" 2> /dev/null |sed 's/^v//;s/\-/\./;s/\(.*\)-\(.*\)/\1/')

GEM = $(THEME_NAME)-$(GIT_VERSION).gem

release: gem
	@git add -A
	@if git diff-index --quiet HEAD --; then echo "No changes"; else git commit -a; fi
	@git push
	gem push $(GEM)


gem: $(GEM)


%-$(GIT_VERSION).gem:
	gem build $*.gemspec



.PHONY: FORCE

VERSION: FORCE
	@echo "Current version: $(GIT_VERSION)"
	@echo $(GIT_VERSION) > $@
