require '../commons.rb'
require 'pp'


input = File.readlines(FILE)
$values = input.map{|x| x.strip.chars}

def isLowPoint? x,y
    surroundings = Array.new
    #puts "Checking for coordinate #{x}/#{y}: #{$values[y][x]}"
    for dx in -1..1 do
        for dy in -1..1 do
            unless y+dy < 0 || x+dx < 0 || y+dy == $values.size || x+dx == $values[0].size
                surroundings << $values[y+dy][x+dx] 
     #           puts "Found #{$values[y+dy][x+dx]} for #{y+dy} / #{x+dx}" 
            end
           
        end        
    end
    return $values[y][x] == surroundings.min
end


puts SP1
riskScore = 0
for y in 0..$values.size-1 do
    for x in 0..$values[y].size-1 do
        if isLowPoint? x,y
            puts "Found low point #{$values[y][x]} for #{x} / #{y}"
            riskScore += 1 + $values[y][x].to_i
        end
    end
end

$directions = ["UP", "DOWN", "RIGHT", "LEFT"]

def exploreBasin? x,y
    return 0 if $values[y][x] == "9" || $values[y][x] == "B"
    $values[y][x] ="B"
    counter = 1
    $directions.each do |d|
        nextLocation = travel(x,y,d) 
        next if nextLocation.nil?     
        counter += exploreBasin? nextLocation[0], nextLocation[1]
    end
    return counter
end

def travel x,y, direction
    case direction
    when "LEFT"
        return [x-1,y] unless x-1 < 0
    when "RIGHT"
        return [x+1,y] unless x+1 == $values[0].size
    when "UP"
        return [x,y+1] unless y+1 == $values.size
    when "DOWN"
        return [x,y-1] unless y-1 < 0
    else 
        return nil
    end
end


puts "--------"
puts "Result: #{riskScore}"

puts SP2

basinSizes = Array.new
for y in 0..$values.size-1 do
    for x in 0..$values[y].size-1 do
        result = 1
        
        basinSizes.push( exploreBasin? x,y )
        
    end
end

puts "--------"
puts "Result: #{basinSizes.sort.reverse.first(3).inject(:*)}"