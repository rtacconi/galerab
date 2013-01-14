class Proxy
  def self.stop
    puts "Terminating ProxyServer"
    EventMachine.stop
  end 
end