describe Configuration do
  before(:each) do
    %x[cp #{ENV['GALERAB_CONFIG_PATH'] + '/galerab.yml.backup'} #{ENV['GALERAB_CONFIG_PATH'] + '/galerab.yml'}]
    @configuration = Configuration.new(ENV['GALERAB_CONFIG_PATH'] + '/galerab.yml')
    @conf = @configuration.conf
  end
  
  context "when loading the file" do
    it "should load the YAML file" do
      @conf.should be_true
    end
  
    it "gets the backends for balancer 1" do
      @conf['backends'].size.should be == 3
      @conf['backends'][0].should be == "192.168.10.101"
      @conf['backends'][1].should be == "192.168.10.102"
      @conf['backends'][2].should be == "192.168.10.103"
    end
    
    it "loads the other parameters" do
      @conf['check_every'].size.should be == 8
      @conf['user'].should be == "your_user"
      @conf['password'].should be == "your_password"
      @conf['database'].should be == "your_db"
      @conf['balancer_port'].should be == 3307
      @conf['backend_port'].should be == 3306
    end
  end
  
  it "should remove a backend from the config file" do
    @configuration.remove_backend("192.168.10.103")
    @conf = @configuration.conf
    @conf['backends'].should_not include("192.168.10.103")
  end
  
  it "should add a backend to the config file" do
    @configuration.remove_backend("192.168.10.103") # make sure there is not that address
    @configuration.add_backend("192.168.10.103")
    @conf = @configuration.conf
    @conf['backends'].should include("192.168.10.103")
  end
  
  it "should not add another backend if it is already in the list" do
    @conf['backends'].size.should be == 3
    @configuration.add_backend("192.168.10.103")
    @conf['backends'].size.should be == 3
  end
end