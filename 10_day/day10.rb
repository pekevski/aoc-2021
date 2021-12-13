

def parse_chunks(line)
    
    stack = []
    
    chars = line.split("");

    chars.each() do |char|

        if ['(', '[', '{', '<'].include? char
            # push opening characters to the stack
            stack.push(char)
            # puts "Push #{char} to stack:\t#{stack}"
        else

            last = stack.last()

            if (char == ')' and last == '(') or (char == ']' and last == '[') or (char == '}' and last == '{') or (char == '>' and last == '<')
                stack.pop()
                # puts "Pop #{char} from stack:\t#{stack}"
            else
                last = stack.last()
                expected = ""
                if last == '('
                    expected = ')'
                elsif last == '['
                    expected = ']'
                elsif last == '{'
                    expected = '}'
                elsif last == '<'
                    expected = '>'
                end
            
                puts "Expected #{expected}, but found #{char} instead."
                return char
            end
        end

    end

    # Get the opposite chars and reverse since we put it in a stack
    return switch_chars(stack).reverse()
end

def score_illegal_chars(chars)

    score = 0

    chars.each() do |char|
        case char
        when ')'
            score += 3
        when ']'
            score += 57
        when '}'
            score += 1197
        when '>'
            score += 25137
        end
    end

    return score
end

def score_incomplete_chars(chars)
    score = 0

    chars.each() do |char|
        case char
        when ')'
            score = 5 * score + 1
        when ']'
            score = 5 * score + 2
        when '}'
            score = 5 * score + 3
        when '>'
            score = 5 * score + 4
        end
    end

    return score
end

def switch_chars(chars)
   
    switched = []

    chars.each() do |char|
        case char
        when '('
            switched.push(')')
        when '['
            switched.push(']')
        when '{'
            switched.push('}')
        when '<'
            switched.push('>')
        end
    end

    return switched
end

filename = ARGV.first

file = open(filename)

illegal_chars = []
incomplete_chars = []

file.each_line() do |line|
    line = line.chomp()

    # puts "Parsing line #{line}"
    result = parse_chunks(line)

    if result.instance_of? String
        illegal_chars.push(result)
    elsif result.instance_of? Array
        incomplete_chars.push(result)
    end
        
end

file.close()

score = score_illegal_chars(illegal_chars)

puts "Part 1 Answer: #{score}"

puts ""

incomplete_line_scores = incomplete_chars.map{|line| score_incomplete_chars(line)}
incomplete_line_scores.sort!();
score2 = incomplete_line_scores[incomplete_line_scores.size() / 2]

puts "Part 2 Answer: #{score2}"