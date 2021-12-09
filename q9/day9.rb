filename = ARGV.first

file = open(filename)

cave_smoke = []
height = 0
width = 0

file.each_line() do |line|
    line = line.chomp()
    width = line.length()
    cave_smoke.append(line.chars().map{|v| v.to_i()})
end

file.close()

height = cave_smoke.count()

# debug results after parsing
puts "Data is #{height} high and #{width} wide"
pp cave_smoke
puts ""

# Part 1
lowest_points = []
lowest_points_coords = []

# Parse the 2d array, greedily
cave_smoke.each().with_index() do |row, i|
    row.each().with_index() do |col, j|

        up = i == 0 ? Float::INFINITY : cave_smoke[i-1][j]
        down = i == height - 1 ? Float::INFINITY : cave_smoke[i+1][j]
        left = j == 0 ? Float::INFINITY : cave_smoke[i][j-1]
        right = j == width - 1 ? Float::INFINITY : cave_smoke[i][j+1]

        if col < up && col < down && col < left && col < right
            lowest_points.append(col)
            lowest_points_coords.append([i,j])
        end

    end
end

puts ""
puts "lowest points values:\t\t#{lowest_points}"
puts "lowest points coordinates:\t#{lowest_points_coords}"
puts "Part 1 Answer: #{lowest_points.map{|v| v+1}.sum()}"
puts ""

#  Part 2
visited = Array.new(height) { Array.new(width, false)}

# Given a coord, check all up, down, left, right points
# recursively until we find a 9
# Output the result of how many coords we traversed
# Ignore points we have already visited. 
def check_basin(map, visited, x, y, height, width)
    result = map[x][y];
    visited[x][y] = true
    
    if result == 9
        return 0
    else
        # the value of each value in the basin is 1 or 0
        # present or not present
        result = 1

        # check the up number if not visited
        if x > 0 and !visited[x-1][y]
            result += check_basin(map, visited, x-1, y, height, width)
        end

        # check the down number if not visited
        if x < height - 1 and !visited[x+1][y]
            result += check_basin(map, visited, x+1, y, height, width)
        end

        # check the left number if not visited
        if y > 0 and !visited[x][y-1]
            result += check_basin(map, visited, x, y-1, height, width)
        end

        # check the right number if not visited
        if y < width - 1 and !visited[x][y+1]
            result += check_basin(map, visited, x, y+1, height, width)
        end

        result
    end

end

basins = []

# iterate through each low point and calculate the basins
lowest_points_coords.each() do |coord|
    x, y = coord
    value = check_basin(cave_smoke, visited, x, y, height, width)
    basins.append(value)
end

basins.sort!{|a,b| b - a}

puts ""
puts "basins:\t\t#{basins}"
puts "Part 2 Answer: #{basins.first(3).reduce(:*)}"
puts ""