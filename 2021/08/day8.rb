require '../commons.rb'
require 'pp'
puts SP1

input = File.readlines(FILE)
#puts input.scan(/\|(.*)$/).size

#puts input.scan(/\|(.*)$/)
sum = 0
list = [2,4,3,7]
input.each do |line|
    words = line.split("|")[1].strip!.split(" ")
    
    words.each do |word|
        if list.include? word.size 
            sum += 1
        end
    end
end

puts "Result #{sum}"

puts SP2
$sum = 0
numbers = Hash.new()

input.each do |line|

    words = line.split("|")[0].strip!.split(" ").map{|x|x.chars.sort}
    
    ## Find 1
    numbers[1] = words.select {|word| word.count == 2  }.flatten
    words.delete(numbers[1])
   
    ## Find 4
    numbers[4] = words.select {|word| word.count == 4  }.flatten
    words.delete(numbers[4])
   
    ## Find 7
    numbers[7] = words.select {|word| word.count == 3  }.flatten
    words.delete(numbers[7])

    ## Find 8
    numbers[8] = words.select {|word| word.count == 7  }.flatten
    words.delete(numbers[8])

    ## Find 3
    numbers[3] = words.select {|word| word.count == 5 && (word & numbers[1]).size == 2 }.flatten
    words.delete(numbers[3])
    
    ## Find 9
    numbers[9] = words.select {|word| word.count == 6 && (word - numbers[3]).size == 1 }.flatten
    words.delete(numbers[9])
      
    ## Find 0
    numbers[0] = words.select {|word| word.count == 6 && (word - numbers[1]).size == 4 }.flatten
    words.delete(numbers[0])
    
    ## Find 6
    numbers[6] = words.select {|word| word.count == 6}.flatten 
    words.delete(numbers[6])
    
    ## Find 5
    numbers[2] = words.select {|word| word.count == 5 && (word - numbers[6]).size == 1 }.flatten
    words.delete(numbers[2])
    
    ## Find 2
    numbers[5] = words.select {|word| word.count == 5}.flatten
    words.delete(numbers[5])
    
    #puts "----- Found all numbers ----"
    #numbers.sort.to_h.each do |k,v|
    #    puts "#{k} is #{v}"
    #end
    outputs = line.split("|")[1].strip!.split(" ").map{|x|x.chars.sort}
    x =""
    outputs.each do |output|
        x << numbers.key(output).to_s
    end
    $sum += x.to_i
end

puts "Result: #{$sum}"