t1 = Thread.new do
  while(true)
    p Time.now
    sleep 500
  end
end

t2 = Thread.new do
  while(true)
    p "t2 exec  "
    sleep 500
  end
end

t1.join
t2.join