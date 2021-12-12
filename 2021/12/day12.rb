require '../commons.rb'
require 'pp'

input = File.readlines(FILE)
$connections = input.map{|x| x.strip.split("-")}
pp $connections if TEST

def nextWayPoint path, listSmallCaves
    current = path.last    
    if current == 'end'
        puts "Found the end for path #{path}" if TEST
        $paths += 1
        return
    elsif current == current.downcase 
        listSmallCaves << current
    end
    
    possibleConnections = $connections.select{|x| x.include?(current)}  
    possibleConnections.each do |connection|
        puts "Current path #{path}, have #{possibleConnections.size} options" if TEST
        nextCave = connection[0] == current ? connection[1] : connection[0]
        if listSmallCaves.include?(nextCave)
            next unless $part == 2 && nextCave != 'start' && listSmallCaves.size == listSmallCaves.uniq.size
        end
        puts "Currently at #{current}, next cave is #{nextCave}" if TEST
        nextWayPoint path.dup << nextCave, listSmallCaves.dup
    end
end

start = Time.now
puts SP1
$paths = 0
$part = 1
nextWayPoint ['start'], []
puts "----------"
puts "Result: #{$paths}"

puts SP2
$paths = 0
$part = 2
nextWayPoint ['start'], []
puts "----------"
puts "Result: #{$paths}"
# code to time
finish = Time.now

puts "It took #{finish - start} seconds to calculate"
