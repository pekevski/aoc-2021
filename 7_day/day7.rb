filename = ARGV.first

file = open(filename)

fuels = []

file.each_line() do |line|
    line = line.chomp()
    fuels = line.split(",").map{|v| v.to_i}
end

file.close()

# Calculate the median of an array of integers
def median(array)
    return nil if array.empty?
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

def mean(array)
    return nil if array.empty?
    array.instance_eval { reduce(:+) / size.to_f }
end

# Part 1 Answer
def calculateMinimumFuel(fuels)
    puts "Part 1 debug"
    result = 0
    median = median(fuels).to_i()
    puts "Median is #{median}"
    
    # Part 1
    fuels.each() do |fuel|
        result += (fuel - median).abs()
    end

    result
end

def rolling_sum(num)
    result = 0

    if num < 0
        result
    else
        while num >= 0
            result += num
            num -= 1
        end
    end

    result
end

def calculateMinimumExponentialFuel(fuels)
    puts "Part 2 debug"
    result = 0
    mean = mean(fuels).floor()
    puts "Mean is #{mean}"
    
    # Part 1
    fuels.each() do |fuel|
        distance = (fuel - mean).abs()
        rolling = rolling_sum(distance)
        # puts "#{fuel} - #{mean} = #{distance} => #{rolling}"
        result += rolling
    end

    result
end


puts "Part 1 Answer is #{calculateMinimumFuel(fuels)}"
puts "Part 1 Answer is #{calculateMinimumExponentialFuel(fuels)}"