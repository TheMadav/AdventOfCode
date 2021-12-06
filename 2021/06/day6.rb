require '../commons.rb'
require 'pp'

input = File.readlines(FILE)


def calculateSmallFish fish
    for i in 1..DAYS do
        fish += [9] * fish.count(0)
        fish.map!{|f|
            if f > 0
                f -= 1
            else
                f = 6
            end
        }
        
         puts FILE == ".test" ? "After #{i} day: #{fish.join(",")}"  : "After #{i} day - Count: #{fish.count}"   
    end
    return fish
end

def calculateBiglFish fish
    for j in 1..DAYS2 do
        oldfish = fish.dup
        fish[8] = oldfish[0]
        for i in 0...8 do
            if oldfish[i+1].nil? 
                oldfish[i+1] = 0
            end
            fish[i] = oldfish[i+1]  
        end
        if fish[6].nil?
            fish[6] = oldfish[0]
        else
            fish[6] += oldfish[0].nil? ? 0 : oldfish[0]
        end
    end
    return fish
end


puts SP1
DAYS = 80
fish = input[0].split(",").map!{|x| x.to_i}
fish = calculateSmallFish fish
puts "----"
puts "Final count of fish: #{fish.count}"


puts SP2
DAYS2 = 256
fish = input[0].split(",").map!{|x| x.to_i}
result = calculateBiglFish fish.tally
sum = 0
result.each do |k,v|
    sum += v
end
puts "---"
puts "Final count of fish: #{sum}"

