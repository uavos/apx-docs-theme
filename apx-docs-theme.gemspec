# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "apx-docs-theme"
  # spec.version       = "0.1.0"
  spec.version       = File.read("VERSION").strip
  spec.authors       = ["Aliaksei Stratsilatau"]
  spec.email         = ["sa@uavos.com"]

  spec.summary       = "Jekyll theme based on bootstrap for UAVOS APX documentation."
  spec.homepage      = "https://github.com/uavos/apx-docs-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", "~> 3.7"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.2"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.10"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.5"
  spec.add_runtime_dependency "jekyll-redirect-from", "~> 0.1"
  spec.add_runtime_dependency 'jekyll-relative-links', "~> 0.1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
end
