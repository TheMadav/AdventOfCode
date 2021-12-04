NA = "NA"
FILE = ARGV[0] == "test" ? 'test.txt' : 'input.txt'
input = File.readlines(FILE)
puts "Number of rows: #{input.size}"
numbers = input.shift

def import_squares
    input = File.readlines(FILE)
    input.shift
    squares = Array.new
    i = -1
    j = 0
    input.each do |row|
        if row.strip!.empty?  
            j = 0
            i += 1
            squares[i] = Array.new
            next
        end
        squares[i][j] = row.split(" ")
        j += 1 
    end
        return squares
end

def print_square square
    puts "---------"
    square.each do |row|
        puts "#{row.join(' ')}"
    end
    
end

def winnerFound? squares, number
    squares.each do |square|
        if full_row?(square) || full_column?(square)
            puts "Square won:"
            print_square square
            squareValue square, number
            return true
        end
    end
    return false
end

def squareValue square, number
    square.flatten!.delete(NA)
    square.map!{|x| x.to_i}
    sum = square.sum
    puts "==============================="
    puts "Winning sum: #{sum}"
    puts "Result #{number.to_i*sum}"
end

def full_row? square
    square.each do |row|
        return true if row.count(NA) == row.size
    end
    return false
end

def full_column? square
    for i in 0...square.size-1 do
        j = 0
        square.each do |row|
            j += 1 if row[i] == NA
        end    
        return true if j == 5
    end
    return false
end

squares = import_squares
i = 0
puts "Number of squares #{squares.size}"
numbers.split(",").each do |number|
    i += 1
    puts "Picked number #{number}"
    
    squares.map!{|square| 
        square.map!{
        |row| 
        row.map!{|x| 
            x = x == number ? NA : x }
    }}
    break if winnerFound? squares, number
end

puts "============== TASK 2=============="


def remainingSquares squares
    return squares.delete_if{|s| (full_row?(s) || full_column?(s))}
end
squares.clear
squares = import_squares
i = 0
puts "Number of squares #{squares.size}"

numbers.split(",").each do |number|
    i += 1
#    puts "Picked number #{number}"
    
    squares.map!{|square| 
        square.map!{
        |row| 
        row.map!{|x| 
            x = x == number ? NA : x }
    }}
    
    if squares.size == 1 && (full_row?(squares[0]) || full_column?(squares[0]) )
        puts "Found last square"
        print_square squares[0]
        squareValue squares[0], number
        break
    else
        squares = remainingSquares squares
        squares.each do |square|
        #    print_square square
        end
    end
    exit if number == 24
end

