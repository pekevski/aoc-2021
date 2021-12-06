# Day 1

filename = ARGV.first
data = open(filename)

count = 0
previous_value = 0;

data.each_line.with_index do |point, index|

    # convert to integer
    value = point.to_i

    # puts "#{index} -> point: #{value}"
    
    if index == 0
        puts "#{value} (N/A - no previous measurement)"
        next
    end
    
    direction = ""

    if value > previous_value
        direction = "increased"
        count = count + 1
    else 
        direction = "decreased"
    end

    puts "#{value} (#{direction})"

    previous_value = value # persist the previous value
end

puts "\nAnswer is #{count}"

file.close