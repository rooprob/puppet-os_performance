notification :off

guard 'rake', :task => 'test' do
  watch(%r{^manifests\/(.+)\.pp$})
  watch(%r{^spec/**/*_spec.rb$})
end
