require '../commons.rb'
require 'pp'
puts SP1


input = File.readlines(FILE).map{|x| x.strip.chars}

opening = Array.new()
closing = Array.new()

pairs = Hash.new()

input.each do
    
    c = row.pop 
    if opening.includes? c
        expectedClosing = pairs[c]
    elsif c == expectedClosing.pop
        puts "is closed agian"
    else
        puts "Exception found in line XY"
    end
    if row.empty and expectedClosing.size > 0
        puts "row is incomplete"
    end
end