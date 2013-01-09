require 'rspec'
ENV['GALERAB_CONFIG_PATH'] = File.dirname(__FILE__) + '/galerab.yml'
require 'galerab'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end