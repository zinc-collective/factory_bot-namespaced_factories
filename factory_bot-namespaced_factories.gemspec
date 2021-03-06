require_relative 'lib/factory_bot/namespaced_factories/version'

Gem::Specification.new do |spec|
  spec.name          = "factory_bot-namespaced_factories"
  spec.version       = FactoryBot::NamespacedFactories::VERSION
  spec.authors       = ["Zee"]
  spec.email         = ["50284+zspencer@users.noreply.github.com"]
  spec.license       = "AGPL-3.0-or-later"

  spec.summary       = %q{Share factories between gems and domains in more complex monoliths.}
  spec.description   = %q{Share factories between gems and domains in more complex monoliths.}
  spec.homepage      = "https://github.com/zinc-collective/factory_bot-namespaced_factories"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zinc-collective/factory_bot-namespaced_factories"
  spec.metadata["changelog_uri"] = "https://github.com/zinc-collective/factory_bot-namespaced_factories"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'factory_bot', '~> 6.0'
end
