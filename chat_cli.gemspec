# frozen_string_literal: true

require_relative "lib/chat_cli/version"

Gem::Specification.new do |spec|
  spec.name = "chat_cli"
  spec.version = ChatCli::VERSION
  spec.authors = ["M01tyan"]
  spec.email = ["M01tyan@users.noreply.github.com"]

  spec.summary = "This is Chat-GPT CLI."
  spec.description = "Chat-GPT Command Line Tools"
  spec.homepage = "https://rubygems.org/gems/chat_cli"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/M01tyan/chat_cli"
  spec.metadata["allowed_push_host"] = "https://rubygems.org/gems/chat_cli"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.files += Dir[".env"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 1.2'
  spec.add_dependency 'ruby-openai', '~> 3.6'
  spec.add_dependency 'dotenv', '~> 2.8'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
