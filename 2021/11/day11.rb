require '../commons.rb'
require 'pp'

ROUND = ARGV[1].to_i

input = File.readlines(FILE)
$octopus = input.map{|x| x.strip.chars.map{|y| y.to_i}}
input = File.readlines('./test10.txt')
$octopusTest = input.map{|x| x.strip.chars.map{|y| y.to_i}}
ROWS = $octopus.size
COLUMNS = $octopus[0].size
$flashedAlready = Array.new()
puts "Starting with: \n"
pp $octopus
$flashesCount = 0 

def flash x, y
    #puts "Puts Octopus at #{x} / #{y} just flashed! Charge value #{$octopus[y][x]}"
    $octopus[y][x] = 0
    $flashedAlready << "#{x}/#{y}"
    for dx in -1..1 do
        for dy in -1..1 do
            unless y+dy < 0 || x+dx < 0 || y+dy == ROWS || x+dx == COLUMNS || $flashedAlready.include?("#{x+dx}/#{y+dy}")
                $octopus[y+dy][x+dx] += 1 
     #           puts "Octopus at #{x+dx}/#{y+dy} increased charge to #{$octopus[y+dy][x+dx]}!"
            end
        end        
    end
    #puts "Burned out octopus at #{x} / #{y} : #{$octopus[y][x]}"
    $flashesCount += 1
end

for i in 1..ROUND do
    $flashedAlready.clear()
    puts "----------"
    puts "Calculation round #{i}"
    $octopus.map!{|rows| rows.map{|o| o += 1}}
    
    while $octopus.flatten.select{|o| o>9}.size > 0
        for y in 0...ROWS do
            for x in 0...COLUMNS do
                if $octopus[y][x] > 9 && ! $flashedAlready.include?("#{x}/#{y}")
                    flash x, y
                end
            end
        end
        if $flashedAlready.size == $octopus.flatten.size
            puts "--------"
            puts "Result Task 2: Synchronized after round #{i}"
            exit
        end
    end
    puts "Result after round #{i}"
    pp $octopus
end

puts "--------"
puts "Result: #{$flashesCount}" 
puts "Comparing #{$octopus==$octopusTest}" if ARGV[0] == 'test'