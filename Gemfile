source "https://rubygems.org"
group :test do
  gem "vagrant-wrapper"
  gem "rake"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 3.8.0'
  gem "rspec"
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
  gem "rspec-puppet-facts"
  gem "rubocop"
  gem 'simplecov'
  gem 'simplecov-console'

  gem "puppet-lint-absolute_classname-check"
  gem "puppet-lint-leading_zero-check"
  gem "puppet-lint-trailing_comma-check"
  gem "puppet-lint-version_comparison-check"
  gem "puppet-lint-classes_and_types_beginning_with_digits-check"
  gem "puppet-lint-unquoted_string-check"
end

group :development do
  gem "pry"
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
  gem "guard-rake"
  gem "librarian-puppet"
end

group :system_tests do
  gem "beaker",
      path: '/tamasiorg/ruby/beaker'
  gem "beaker-rspec",
      path: '/tamasiorg/ruby/beaker-rspec'
  gem "beaker-puppet_install_helper"
end
