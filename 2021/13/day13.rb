require '../commons.rb'
require 'pp'

def import
    $dots = Array.new
    $foldingInstructions = Array.new
    input = File.readlines(FILE)
    input.each do |row|
        if row.split(",").size ==2
            dot = row.strip.split(",")
            $dots << {:x => dot[0].to_i, :y => dot[1].to_i }

        elsif row[0..3] == "fold"
            fold = row.strip.split("=")
            $foldingInstructions << {:direction => fold[0][-1], :coordinate => fold[1].to_i}
        end
    end
end

    
def fold count
    $foldingInstructions[0...count].each do |fold|
        $dots.each do |d|
            
            if fold[:direction] == "x" && d[:x]>fold[:coordinate]
                d[:x] = d[:x] - (d[:x]-fold[:coordinate])*2
            elsif fold[:direction] == "y" && d[:y]>fold[:coordinate]
                d[:y] = d[:y] - (d[:y]-fold[:coordinate])*2
            end
        end
    end
end

def printResult 


    for y in 0...YMAX do
        line =""
        for x in 0...XMAX do
            line += $dots.select{|d| d[:x] == x && d[:y] == y}.size >0 ? "X" : " "
        end
        puts line
    end 
end

puts SP1
import
puts "Number of Dots: #{$dots.count}"
fold 1
dotCount = $dots.group_by{|row| [row[:x],row[:y]]}.keys.size
puts "------"
puts "Result: #{dotCount}"

puts SP2+"\n\n"
import
fold $foldingInstructions.size
XMAX = $dots.map{|d| d[:x]}.max+2
YMAX = $dots.map{|d| d[:y]}.max+2
printResult


