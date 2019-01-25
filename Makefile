

THEME_NAME := apx-docs-theme

release: gem
	gem build $(THEME_NAME).gemspec
	gem push $(THEME_NAME)-*.gem


gem:
	gem build $(THEME_NAME).gemspec
