

THEME_NAME := apx-docs-theme

GIT_VERSION = $(shell git describe --tags --match="v*.*" 2> /dev/null |sed 's/^v//;s/\-/\./;s/\(.*\)-\(.*\)/\1/')

GEM = $(THEME_NAME)-$(GIT_VERSION).gem

release: git-push gem
	gem push $(GEM)


gem: $(GEM)

git-push: FORCE
	@git add -A
	@if git diff-index --quiet HEAD --; then echo "No changes"; else git commit -a; fi
	@git push


%-$(GIT_VERSION).gem:
	gem build $*.gemspec



.PHONY: FORCE

VERSION: FORCE
	@echo "Current version: $(GIT_VERSION)"
	@echo $(GIT_VERSION) > $@
