module BalancingProxy
  extend self

  # Callbacks for em-proxy events
  #
  module Callbacks
    include ANSI::Code
    extend  self

    def on_select
      lambda do |backend|
        puts black_on_white { 'on_select'.ljust(12) } + " #{backend.inspect}"
        backend.increment_counter if Backend.strategy == :balanced
      end
    end

    def on_connect
      lambda do |backend|
        puts black_on_magenta { 'on_connect'.ljust(12) } + ' ' + bold { backend }
      end
    end
    
    def on_data
      lambda do |data|
        puts black_on_yellow { 'on_data'.ljust(12) }, data
        data
      end
    end

    def on_response
      lambda do |backend, resp|
        puts black_on_green { 'on_response'.ljust(12) } + " from #{backend}", resp
        resp
      end
    end

    def on_finish
      lambda do |backend|
        puts black_on_cyan { 'on_finish'.ljust(12) } + " for #{backend}", ''
      end
    end

  end
  
  module Server
    def run(backend)
      # run the proxy server and wait for connections
      balancer_port = backend.conf["balancer_port"]
      backend_port = backend.conf["backend_port"]
      puts ANSI::Code.bold { "Launching proxy at 0.0.0.0:#{balancer_port}...\n" }

      Proxy.start(:host => '0.0.0.0', :port => balancer_port, :debug => false) do |conn|
        backend_host = backend.get_next
        if backend_host
          conn.server backend_host, :host => backend_host, :port => backend_port
          puts ANSI::Code.bold { "Farwarding to #{backend_host}\n" }

          conn.on_connect  &Callbacks.on_connect
          conn.on_data     &Callbacks.on_data
          conn.on_response &Callbacks.on_response
          conn.on_finish   &Callbacks.on_finish
        end
      end
    end

    module_function :run
  end
end
