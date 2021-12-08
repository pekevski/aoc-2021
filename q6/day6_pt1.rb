filename = ARGV.first

file = open(filename)

input = []

file.each_line() do |line|
    line = line.chomp()
    input = line.split(",").map{|v| v.to_i}
end

file.close()

puts "Initial state:\t#{input.clone().join(",")}"

def make_lanternfish(days, lanternfish)

    for day in 0..days-1

        fish_to_add = []
    
        lanternfish.map!() do |fish|
    
            new_fish = fish - 1
    
            if new_fish < 0
                # reset timer
                new_fish = 6
    
                # append new fish
                fish_to_add.append(8)
            end
    
            new_fish
        end
    
        lanternfish.append(*fish_to_add)
        puts "#{lanternfish.count()} fish"
    
        # puts "After #{day + 1} day#{day == 1 ? 's' : ''}:\t#{lanternfish.join(",")}"
    end

    return lanternfish.count()

end


puts "Part 1 Answer: #{make_lanternfish(80, input.clone())}"

# bad implementation :(
# puts "Part 2 Answer: #{make_lanternfish(256, input.clone())}"