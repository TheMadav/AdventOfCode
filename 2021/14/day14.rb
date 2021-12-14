require '../commons.rb'
require 'pp'

input = File.readlines(FILE).map(&:strip)

seed = input[0]
$rules = input[2..].map{|l| l.split ' -> '}.to_h

pairs = Hash.new()
for i in 0...seed.size-1 do
    pairs[seed[i..i+1]] =  pairs[seed[i..i+1]].nil? ? 1 : pairs[seed[i..i+1]] +1
end

def calcualteElements pairs
    newPair = Hash.new()
    pairs.each do |key, value|
        newPair["#{key[0]}#{$rules[key]}"] = newPair["#{key[0]}#{$rules[key]}"].nil? ? value : newPair["#{key[0]}#{$rules[key]}"] + value
        newPair["#{$rules[key]}#{key[1]}"] = newPair["#{$rules[key]}#{key[1]}"].nil? ? value : newPair["#{$rules[key]}#{key[1]}"] + value
        $elements[$rules[key]] = ($elements[$rules[key]].nil?) ? 1 : $elements[$rules[key]]+value
    end
    return newPair
end

$elements = Hash.new()

puts SP1
ROUND1 = 10
for i in 1..ROUND1 do
    pairs = calcualteElements pairs
    puts "Step #{i}: Total pairs #{pairs.size}"
    puts "----"
end
puts "----"
puts "Max amount #{$elements.values.max}"
puts "Min amount #{$elements.values.min}"
puts "Result: #{$elements.values.max-$elements.values.min} "

puts SP2
ROUND2 = 40
for i in ROUND1+1..ROUND2 do
    pairs = calcualteElements pairs
    puts "Calculating step #{i}"
end
puts "----"
puts "Max amount #{$elements.values.max}"
puts "Min amount #{$elements.values.min}"
puts "Result: #{$elements.values.max-$elements.values.min} "