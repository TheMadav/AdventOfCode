require '../commons.rb'
require 'pp'

input = File.read(FILE).split(",").map!{|x| x.to_i}.sort!

min = input.min
max = input.max

puts SP1
puts "Minimal position: #{min}"
puts "Maximal position: #{max}"

minimalMovement = input.max*input.size

for i in input.min...input.max do
    movement = 0
    input.each do |x|
        movement += (x-i).abs
        break if minimalMovement < movement
    end
    if movement < minimalMovement
        minimalMovement = movement
        minimalPosition = i
    end
    #puts "Horizontal position #{i} requires movement of #{movement}"
end

def calculateDistance a,b   
    n = (a-b).abs
    return n*(n+1)/2
end
puts "------"
puts "Result: #{minimalPosition} requires #{minimalMovement}"

puts SP2
puts "Minimal position: #{min}"
puts "Maximal position: #{max}"
minimalMovement = input.max*input.size**2

for i in input.min...input.max do
    movement = 0
    input.each do |x|
        movement += calculateDistance x,i
        break if minimalMovement < movement
    end
    if movement < minimalMovement
   #     puts "New minimal position #{i}: #{movement}"
        minimalMovement = movement
        minimalPosition = i
    end
    
end
puts "------"
puts "Result: #{minimalPosition} requires #{minimalMovement}"