# Day 1

filename = ARGV.first
data = open(filename)

count = 0
previous_value = 0;

data.each_line.each_cons(3).each_with_index do |(prev, curr, nxt), index|

    # convert to integer
    prev_value = prev.chomp.to_i
    curr_value = curr.chomp.to_i
    nxt_value = nxt.chomp.to_i

    # puts "prev: #{prev_value}, curr: #{curr_value}, next: #{nxt_value}"

    value = prev_value + curr_value + nxt_value
    
    if index == 0
        puts "#{index}: #{value} (N/A - no previous measurement)"
        next
    end
    
    direction = ""

    if value > previous_value
        direction = "increased"
        count = count + 1
    else 
        direction = "decreased"
    end

    puts "#{index}: #{value} (#{direction})"

    previous_value = value # persist the previous sum value
end

puts "\nAnswer is #{count}"

