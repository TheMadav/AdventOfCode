require '../commons.rb'
require 'pp'

lines = File.readlines(FILE).map{|x| x.strip.chars}

## SETUP

opening = ["(", "[", "{", "<"]
closing = [")", "]", "}", ">"]

errorPoints,autocompletePoints  = Hash.new()
errorPoints = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }
autocompletePoints = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }

pairs = Hash.new()
for i in 0...opening.size do
    pairs[opening[i]] = closing[i]
end

pp pairs
puts SP1
errorScore = 0
autocompleteScores = Array.new
for i in 0...lines.size do
    #puts "Analyzing line \n#{lines[i]}\n"
    exception = false
    expectedClosing = Array.new()
    lines[i].each do |c|
        
        if opening.include? c
        #    puts "Found #{c} - add to expectedClosing #{pairs[c]}"
            expectedClosing << pairs[c]
        #    puts "#{expectedClosing}"
        elsif expectedClosing.size >0 && c == expectedClosing.last
            expectedClosing.pop
        #    puts "is closed agian"
        else
            puts "Exception found in line #{i+1}, expected #{expectedClosing.last}, found #{c}"
            puts "Error score #{errorPoints[c]}"
            errorScore += errorPoints[c]
            exception = true
            break
        end
    end
    if expectedClosing.size > 0 && !exception
        score = 0
        expectedClosing.reverse.each do |c|
        #    puts "Current score #{score}, multiplied #{score*5} - add #{autocompletePoints[c]}"
            score = score*5 + autocompletePoints[c]
        end
        autocompleteScores << score
    elsif !exception
        puts "Line #{i+1} is complete"
    end
end

puts "--------"
puts "Result: #{errorScore}"


puts SP2
puts "Result: #{autocompleteScores.sort[autocompleteScores.size/2]}"