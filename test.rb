hash = {:a => 10, :b => 10, :c => 34}
selected = hash.select{|x,y| y == 10}
print selected 