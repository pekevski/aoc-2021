require 'set'

class Vertex
    attr_accessor :vertex, :small, :twice

    def initialize(vertex, small, twice)
        @vertex = vertex
        @small = small
        @twice = twice
    end
end

class Graph
    
    def initialize()
        @adjacencyList = {}
    end

    # Add an edge to the graph
    def addEdge(source, destination)
        if @adjacencyList[source] == nil
            @adjacencyList[source] = [destination]
        else
            @adjacencyList[source].append(destination)
        end

        if @adjacencyList[destination] == nil
            @adjacencyList[destination] = [source]
        else
            @adjacencyList[destination].append(source)
        end
        
    end

    def getNeighbours(v)
        return @adjacencyList[v]
    end

    def print()
        pp @adjacencyList
    end

    def Graph.BFS(g, source, destination)
        ans = 0
        start = Vertex.new(source, Set[source], nil)
        queue = [start]

        while !queue.empty?() do
            node = queue.shift()

            v = node.vertex
            small = node.small
            twice = node.twice

            # puts "Vertex #{v}, Small: #{small}"

            if v == destination
                ans += 1
                next
            end

            g.getNeighbours(v).each() do |w|
                if !small.include?(w)
                    new_small = small.clone()

                    if w == w.downcase
                        new_small.add(w)
                    end

                    new_node = Vertex.new(w, new_small, twice)
                    queue.push(new_node)
                    
                elsif small.include?(w) && twice == nil && !['start', 'end'].include?(w)
                    new_node = Vertex.new(w, small, w)
                    queue.push(new_node)
                end
            end
        end

        return ans
    end
end

g = Graph.new()

filename = ARGV.first
file = open(filename)

file.each_line() do |line|
    line = line.chomp()
    source, destination = line.split("-")
    g.addEdge(source,destination)
end

file.close()


g.print()
result = Graph.BFS(g, 'start', 'end')
puts result