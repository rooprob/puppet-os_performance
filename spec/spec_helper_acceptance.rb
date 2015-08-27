require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :target_module_path => '/etc/puppet/modules', :module_name => 'os_performance')
    modules = File.join('modules', '*')
    puts "installing modules #{modules}"
    Dir.glob(modules) do |name|
      puppet_module_install(:source => File.join(proj_root, name), :target_module_path => '/etc/puppet/modules', :module_name => File.basename(name))
    end
  end
end
