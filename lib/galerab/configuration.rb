class Configuration
  attr_accessor :conf
  
  def initialize(path)
    @conf = YAML.load_file(path)
    @path = path
  end
  
  def remove_backend(address)
   @conf['backends'].delete(address)
   File.open(@path, 'w+') {|f| f.write(@conf.to_yaml) }
  end
  
  def add_backend(address)
   @conf['backends'] << address unless @conf['backends'].include?(address)
   File.open(@path, 'w+') {|f| f.write(@conf.to_yaml) }
  end
end