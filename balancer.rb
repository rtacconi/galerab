#!/usr/bin/env ruby

require './require'

path = ARGV.include?('-c') && ARGV[ARGV.index('-c') + 1]

unless path
  puts "Missing port number"
  puts "Usage: command -c /absolute/path/file.yml"
  abort
end


puts "[#{Process.pid}] galerab starting with config file at #{ARGV[1]}"

confs = Configuration.new(path).conf

confs.each do |conf|
  backend = Backend.new(conf[1])
  conf = conf[1]
  
  fork do
    t = Thread.new do
      while true
        # Here we check if the backend is ready
        next_backend = backend.get_next
        puts "\nChecking if (wsrep_ready == ON) #{next_backend}\n"
        
        begin
          Sequel.connect(
            "mysql://#{conf["user"]}:#{conf["password"]}@#{next_backend}/#{conf["database"]}"
          ).fetch("show status like 'wsrep_ready'") do |row|
            #row[:Value] = "OFF"
            if row[:Value] == "OFF"
              puts "#{next_backend} is not ready"
              backend.not_ready.push(next_backend) unless backend.not_ready.include?(next_backend)
            elsif row[:Value] == "ON"
              puts "#{next_backend} is ready"
              backend.not_ready.delete(next_backend) if backend.not_ready
            end
          end
        rescue
          puts "#{next_backend} is not ready"
          backend.not_ready.push(next_backend) unless backend.not_ready.include?(next_backend)
        end

        sleep conf["check_every"]
      end
    end
    
    t.join
    BalancingProxy::Server.run(backend)
  end
end

trap (:SIGHUP) do
  $stdout.puts "Received SIGHUP, reloading config file"
  backend.conf = YAML.load_file(ARGV[1])
  $stdout.puts backend.conf["balancer_ports"].inspect
end

# release child processes before exit
confs.each { |conf| Process.wait }
