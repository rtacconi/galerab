class Proxy
  def self.stop
    puts "Terminating ProxyServer"
    EventMachine.stop
  end
  
  # this is not used
  def self.kill_childs(servers, signal)
    servers.each do |server|
      puts "Killing process #{server[:pid]} with #{signal} signal."
      Process.kill(signal, server[:pid])
    end

    Process.kill(signal, Process.pid)
  end  
end