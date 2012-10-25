require "rubygems"
require "thread"
require 'yaml'
require 'mysql'
require 'sequel'

class Backend
  attr_accessor :not_ready
  
  @@conf = YAML.load_file('config.yml')
  @@list = @@conf["backends"]
  @@not_ready = []

  def conf
    @@conf
  end

  def initialize
    @next_host = 0
  end

  def get_next
    @next_host = @next_host + 1
    @next_host = 0 if @next_host >= @@list.size
    @@list[@next_host]
  end
end

b = Backend.new

Thread.new do # Here we start a new thread
  while true
    next_backend = b.get_next
    p 'Here we start a new thread'
  
    Sequel.connect(
      "mysql://#{b.conf["user"]}:#{b.conf["password"]}@#{next_backend}/#{b.conf["database"]}"
    ).fetch("show status like 'wsrep_ready'") do |row|
      if row[:Value] == "OFF"
        b.not_ready.push(next_backend) unless b.not_ready.include?(next_backend)
      elsif row[:Value] == "ON"
        b.not_ready.delete(next_backend)
      end
    end
  
    sleep b.conf["check_every"]
  end
end

while true
  puts "main program"
  sleep 1
end