filename = ARGV.first

# Find the most common string in an array of strings
# bits_arr only contains char 0 and 1
def most_frequent_bit(bits_arr)
    return bits_arr.max_by{|bit| bits_arr.count(bit)}
end

file = open(filename)

input = []

file.each_line do |line|
    input.push(line.chomp)
end

file.close

# array with 6bits long where each bit holds the characters of
# each line from the input
bits_arr = []

input.each do |line|
    puts "Parsing line: #{line}"
    line.chomp.each_char.with_index { |c, index|

        # Create an array if its the first time
        # creating a bit for a line
        if bits_arr[index] === nil
            bits_arr[index] = [c]
        else
            bits_arr[index].push(c)
        end

        # puts "index #{index}: value #{c} -> #{bits_arr[index]}"
        puts "index #{index}: value #{c}"
    }

    puts ""
end

gamma_rate_string = ""
epsilon_rate_string = ""

bits_arr.each do |bit_arr|
    frequent_bit = most_frequent_bit(bit_arr)
    epsilon_rate_string += frequent_bit === "1" ? "0" : "1"
    gamma_rate_string += frequent_bit
end

gamma_rate = gamma_rate_string.to_i(2)
epsilon_rate = epsilon_rate_string.to_i(2)

puts gamma_rate
puts epsilon_rate

puts "Answer is #{gamma_rate * epsilon_rate}"

