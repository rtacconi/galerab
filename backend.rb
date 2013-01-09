class Backend
  attr_accessor :not_ready, :conf
  
  def initialize(conf)
    @next_host = 0
    @list = conf['backends']
    @conf = conf
    @not_ready = Array.new
  end

  # round robin load-balancing
  def get_next
    @next_host = @next_host + 1
    @next_host = 0 if @next_host >= @list.size
    unless @not_ready.include?(@list[@next_host])
      @list[@next_host]
    else
      begin
        get_next
      rescue SystemStackError
          nil
      end
    end
  end
end