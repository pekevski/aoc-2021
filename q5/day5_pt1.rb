
class Point

    attr_reader :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def debug()
        return "#{@x},#{@y}" 
    end

    # For Hash equality
    def ==(other)
        self.class === other and
        self.x == other.x and
        self.y == other.y
    end

    alias eql? ==

    def hash
        @x.hash ^ @y.hash
    end

end

class Line

    attr_reader :p1, :p2, :points

    def initialize(point1, point2)
        @p1 = point1
        @p2 = point2
        @points = Line.get_line(point1.x, point2.x, point1.y, point2.y)
    end

    def debug()
        print "Line: (#{@p1.debug()}) -> (#{@p2.debug()})\n"
    end

    def is_straight()
        return @p1.x == @p2.x || @p1.y == @p2.y
    end

    # Bresenham's Line Algorithm
    # - get the points between two points of a line
    def self.get_line(x0,x1,y0,y1)
 
        points = []

        steep = ((y1-y0).abs) > ((x1-x0).abs)

        if steep
          x0,y0 = y0,x0
          x1,y1 = y1,x1
        end

        if x0 > x1
          x0,x1 = x1,x0
          y0,y1 = y1,y0
        end

        deltax = x1-x0
        deltay = (y1-y0).abs
        error = (deltax / 2).to_i
        y = y0
        ystep = nil

        if y0 < y1
          ystep = 1
        else
          ystep = -1
        end

        for x in x0..x1
          if steep
            points.append(Point.new(x, y))
          else
            points.append(Point.new(y, x))
          end
          error -= deltay
          if error < 0
            y += ystep
            error += deltax
          end
        end

        return points
      end

end

class Graph

    attr_reader :lines, :intersection_count, :point_map

    def initialize(lines)
        @lines = lines

        map = Hash.new()

        @lines.each() do |line|
            line.points.each() do |point|

                if map[point] == nil
                    map[point] = 1
                else
                    map[point] = map[point] + 1
                end
            end
        end

        @point_map = map
        @intersection_count = map.values.filter{|v| v > 1}.count()

    end

    def draw()

        max_x = @lines.map { |l| [l.p1.x, l.p2.x]}.flatten().max()
        max_y = @lines.map { |l| [l.p1.y, l.p2.y]}.flatten().max()

        puts "Graph is #{max_x} by #{max_y} long..."

        # Instantiate the graph with n x m units
        graph = Array.new(max_x + 1) { Array.new(max_y + 1) {"."} }

        @point_map.each() do |key, value|
            graph[key.x][key.y] = value 
        end

        graph.each() do |row|
            row.each() do |col|
                print col
            end
            print "\n"
        end
        
    end

end

lines = []

filename = ARGV.first

file = open(filename)

file.each_line() do |line|
    line = line.chomp()
    # puts "Parsing line: #{line}"

    points = []

    # ['0,9', '5,9']
    coords_str = line.split(" -> ")

    coords_str.each() do |point_str|
        # [0,9]
        coord = point_str.split(",").map{|c| c.to_i()}
        point = Point.new(*coord)
        points.append(point)
    end
    
    line = Line.new(*points)
    lines.append(line)
end

file.close()

vertical_lines = lines.filter {|l| l.is_straight()}

# Straight Lines
puts "Straight Lines: #{vertical_lines.count}"
vertical_lines.each() do |line|
    line.debug()
end

# All Lines
puts "All Lines: #{lines.count}"
lines.each() do |line|
    line.debug()
end

graph = Graph.new(vertical_lines)
# graph.draw()

puts "Part 1: Answer #{graph.intersection_count}"

# Diagonal and Straight lines
graph = Graph.new(lines)
# graph.draw()

puts "Part 2: Answer #{graph.intersection_count}"