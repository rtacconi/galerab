require 'sinatra/base'
require 'thin'

class App < Sinatra::Base

  get '/' do
    "hi"
  end

  def self.run!
    rack_handler_config = {}

    ssl_options = {
      :private_key_file => '/Users/riccardotacconi/dev/server.key',
      :cert_chain_file => '/Users/riccardotacconi/dev/server.crt',
      :verify_peer => false,
    }

    Rack::Handler::Thin.run(self, rack_handler_config) do |server|
      server.ssl = true
      server.ssl_options = ssl_options
    end
  end
end

App.run!