require 'spec_helper'

describe Configuration do
  before(:each) do
    @conf = Configuration.new(ENV['GALERAB_CONFIG_PATH']).conf
  end
  
  context "when loading the file" do
    it "should load the YAML file" do
      @conf.should be_true
    end
  
    it "should find two balancers in the config file" do
      @conf.size.should be == 2
    end
  
    it "gets the backends for balancer 1" do
      @conf[1]['backends'].size.should be == 3
      @conf[1]['backends'][0].should be == "192.168.10.101"
      @conf[1]['backends'][1].should be == "192.168.10.102"
      @conf[1]['backends'][2].should be == "192.168.10.103"
    end
    
    it "loads the other parameters" do
      @conf[1]['check_every'].size.should be == 8
      @conf[1]['user'].should be == "your_user"
      @conf[1]['password'].should be == "your_password"
      @conf[1]['database'].should be == "your_db"
      @conf[1]['balancer_port'].should be == 3307
      @conf[1]['backend_port'].should be == 3306
    end
  end
end
