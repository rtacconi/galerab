Gem::Specification.new do |spec|
  spec.name                       = 'galerab'
  spec.version                    = '0.0.1'
  spec.date                       = '2013-01-09'
  spec.summary                    = "Load balancer for galera cluster"
  spec.description                = "This load balancer is a transparent proxy to route r/w requests to MySql backends"
  spec.authors                    = ["Riccardo Tacconi"]
  spec.email                      = 'rtacconi@virtuelogic.net'
  spec.files                      = Dir['lib/*.rb'] + Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['files/*']
  spec.test_files                 = Dir.glob("{spec,test}/**/*.rb")
  spec.require_paths              << 'lib'
  spec.require_paths              << 'lib/galera'
  spec.homepage                   = 'http://github.com/rtacconi/galerab'
  spec.add_runtime_dependency     'mysql2', '>= 0.3.11'
  spec.add_runtime_dependency     'sequel', '>= 3.40.0'
  spec.add_runtime_dependency     'em-proxy', '>= 0.1.7'
  spec.add_runtime_dependency     'ansi', '~> 1.4.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.5'
  spec.licenses                   = ['MIT']
  spec.executables                   << 'galerab'
end
