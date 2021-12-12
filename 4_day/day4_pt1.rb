
# BingoBoard Classes

class BingoBoardValue
    @value = nil
    @marked = false

    def initialize(value, marked)
        @value = value.to_i
        @marked = false
    end

    def mark()
        @marked = true
    end

    def get_value()
        return @value
    end

    def is_marked()
        return @marked
    end

    def debug()
        print @value
    end
end

class BingoBoard
    @id = nil
    @board = nil
    @bingo = false
    
    def initialize(id)
        @id = id
        @board = []
        @bingo = false
    end

    def has_bingo()
        return @bingo
    end

    def get_id()
        return @id
    end

    def sum_unmmarked()
        sum = 0

        @board.each do |row|
            row.each do |col|
                if !col.is_marked()
                    sum += col.get_value()
                end
            end
        end

        puts "Unmarked Sum of Board #{@id}: #{sum}"

        return sum
    end

    def add_row(row)
        @board.append(row)
    end

    # Want to mark all matching values in the board
    def mark(value)
        @board.each().with_index() do |row, x|
            row.each().with_index() do |col, y|
                if value == col.get_value()
                    col.mark()
                    if @bingo == false
                        check_row(x)
                    end
                    if @bingo == false
                        check_col(y)
                    end
                end
            end
        end
    end

    def check_row(x)
        all_marked = true

        @board[x].each() do |col|
            all_marked = all_marked && col.is_marked()
        end

        if all_marked
            @bingo = true;
        end
    end

    def check_col(y)
        all_marked = true

        @board.each() do |row|
            all_marked = all_marked && row[y].is_marked()
        end

        if all_marked
            @bingo = true;
        end
    end

    def debug
        puts "-- Board #{@id} --"
        @board.each do |row|
            row.each do |col|
                print "#{col.debug()},"
            end
            print "\n"
        end
        print "\n"

        @board.each do |row|
            row.each do |col|
                print "#{col.is_marked() ? 'x' : '-'} "
            end
            print "\n"
        end
        print "\n"
    end
end

filename = ARGV.first
file = open(filename)

bingo_input = []
bingo_boards = []
current_board = nil
board_count = 0

# On first file iteration
# - Store our bingo inputs
# - Construct and store our bingo boards
file.each_line().with_index() do |line, index|
    line = line.chomp()
    puts "Parsing #{index}: '#{line}'" 

    # when we have an empty new line in the data
    # save the current board if we have one
    # and create a new current board
    if line == ""
        
        # puts "We have an empty line!"

        if current_board != nil
            puts "Adding board:"
            current_board.debug()
            bingo_boards.append(current_board)
        end

        # puts "board count #{board_count}"
        current_board = BingoBoard.new(board_count)
        board_count += 1
        next
    end

    # save the first line as its the bingo input
    if index == 0
        bingo_input = line.split(",").map{|val| val.to_i()}
        # puts "Save bingo input: #{bingo_input}"
    else
        # puts "Adding line "
        # Add the rest of the lines to the current bingo board
        row = line.split(" ").map{|val| BingoBoardValue.new(val, false)}

        current_board.add_row(row)
    end

end

if current_board != nil
    bingo_boards.append(current_board)
end


file.close()


# On input iteration
# - Create a marked map 

print "Input: #{bingo_input}\n"

bingo = false;
board_id = nil;
board_sum = 0;
last_input = nil;

bingo_input.each() do |input|

    if bingo == false
        bingo_boards.each{|board| 
            board.mark(input)
            board.debug()
            puts " => Unmarked Sum: #{board.sum_unmmarked()}, Bingo: #{board.has_bingo()}" 
        }
        bingo_boards.each(){|board| 
            if board.has_bingo()
                bingo = true
                board_id = board.get_id()
                board_sum = board.sum_unmmarked()
                last_input = input
            end
        }
    else
        # BINGO!
        break
    end
end

puts "Board #{board_id} has BINGO! Answer is #{board_sum} * #{last_input} = #{board_sum * last_input}"
