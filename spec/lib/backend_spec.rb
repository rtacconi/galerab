require 'spec_helper'

describe Backend do
  before(:each) do
    @conf = Configuration.new(ENV['GALERAB_CONFIG_PATH'] + '/galerab.yml').conf
    @backend = Backend.new(@conf)
  end
  
  context "round robin load balancing" do
    it "returns the next backend" do
      @backend.get_next.should be == "192.168.10.102"
      @backend.get_next.should be == "192.168.10.103"
      @backend.get_next.should be == "192.168.10.101"
      @backend.get_next.should be == "192.168.10.102" # and again... that's why it is called round robin
    end
    
    it "does not return a backend that is not ready" do
      @backend.not_ready.push("192.168.10.103")
      @backend.get_next.should be == "192.168.10.102"
      @backend.get_next.should be == "192.168.10.101"
    end
  end
end
