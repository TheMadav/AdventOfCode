require '../commons.rb'
require 'pp'

input = File.readlines(FILE).map(&:strip)[0].scan(/x=.*, y=.*/)[0].split(",")
$target = {
    :xmin => input[0][2...].split("..")[0].to_i,
    :xmax => input[0][2...].split("..")[1].to_i,
    :ymin => input[1][3...].split("..")[0].to_i,
    :ymax => input[1][3...].split("..")[1].to_i
}

def move_probe position, velocity
    position[:x]    = position[:x] + velocity[:xv]
    position[:y]    = position[:y] + velocity[:yv]
    
    velocity[:xv]   = velocity[:xv] > 0 ? velocity[:xv] -1 : velocity[:xv] + 1 unless velocity[:xv] == 0
    velocity[:yv]   = velocity[:yv] -1 
    
    return position, velocity
end

def experiment position, velocity
    maxheight = position[:y]
    loop do
        position, velocity = move_probe position, velocity
        maxheight = position[:y] > maxheight ? position[:y] : maxheight
        if TEST
            puts "----"
            puts "#{position}, maxheight: #{maxheight}"
            puts "#{velocity}"
        end
        success = position[:x] >= $target[:xmin] && position[:x] <= $target[:xmax] &&
             position[:y] >= $target[:ymin] && position[:y] <= $target[:ymax] 
        break if position[:x] > $target[:xmax] || position[:y] < $target[:ymin] || success
    end
   
    success = position[:x] >= $target[:xmin] && position[:x] <= $target[:xmax] &&
        position[:y] >= $target[:ymin] && position[:y] <= $target[:ymax] 
    #puts "Final position #{position[:x]} / #{position[:y]}" if success
    return success, maxheight
end

$successful = Array.new
for xv in 1...$target[:xmax]*2
    for yv in $target[:ymax]*2...$target[:ymax]*-2
        success, maxheight = experiment({:x=> 0, :y => 0}, {:xv=> xv, :yv=> yv })
        if success
            #puts " #{xv}, #{yv} Attempt was succesful: #{maxheight}"
            $successful << {:xv => xv, :yv => yv, :maxheight => maxheight}
        end
    end
end
puts "----------"
best = $successful.max_by{|x| x[:maxheight]}
puts "Successful solutions #{$successful.size}"
puts "Result: #{best[:xv]} / #{best[:yv]} reached #{best[:maxheight]}"

#546 <- to low