filename = ARGV.first

file = open(filename)

horizontal_pos = 0
depth_pos = 0

file.each_line do |line|
    instruction, value = line.split
    value = value.to_i

    case instruction
    when "forward"
        horizontal_pos = horizontal_pos + value
    when "down"
        depth_pos = depth_pos + value
    when "up"
        depth_pos = depth_pos - value
    end
end

puts "Horizontal Position: #{horizontal_pos}, Depth Position: #{depth_pos}"
puts "Answer is: #{horizontal_pos * depth_pos}"

file.close