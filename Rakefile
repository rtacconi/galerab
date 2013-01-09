require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

desc 'Run specs with rspec'
task :default => :spec

namespace :install do
  task :debian do
    `cp files/galerab /etc/init.d/`
    `chmod 755 /etc/init.d/galerab`
    `cp files/galerab.yml /etc/`
    `update-rc.d /etc/init.d/galerab defaults`
  end
end