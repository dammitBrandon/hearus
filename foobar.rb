def foobar_counter
  (1..100).each do |num|
    if (num % 3 == 0 ) && (num % 5 == 0)
      puts "foobar"
    elsif (num % 3 == 0 )
      puts "foo"
    elsif ( num % 5 == 0 )
      puts "bar"
    else
      puts num
    end
  end
end

foobar_counter
