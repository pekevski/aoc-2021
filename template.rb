filename = ARGV.first

file = open(filename)

file.each_line() do |line|
    line = line.chomp()

    puts "line: #{line}"
end

file.close()