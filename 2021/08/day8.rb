require '../commons.rb'

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