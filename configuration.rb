class Configuration
  attr_accessor :conf
  
  def initialize(path)
    @conf = YAML.load_file(path)
  end
end