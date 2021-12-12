require '../commons.rb'
require 'pp'

input = File.readlines(FILE)
$connections = input.map{|x| x.strip.split("-")}
pp $connections if TEST
$paths = Array.new

def nextWayPoint path, listSmallCaves 
    current = path.last
    if current == current.downcase && current != "end"
        listSmallCaves << current
    end
    if current == 'end'
        puts "Found the end for path #{path}" if TEST
        $paths << path.dup
        return
    end
  
    possibleConnections = $connections.select{|x| x.include?(current)}  
    puts "At point #{current} found #{possibleConnections} options" if TEST
    possibleConnections.each do |connection|
        puts "Current path #{path}, have #{possibleConnections.size} options" if TEST
        nextCave = connection[0] == current ? connection[1] : connection[0]
        if listSmallCaves.include?(nextCave)
            ## For part 1 remove the condition here
            next unless nextCave != 'start' && listSmallCaves.size == listSmallCaves.uniq.size
        end
        puts "Currently at #{current}, next cave is #{nextCave}" if TEST
        nextWayPoint path.dup << nextCave, listSmallCaves.dup
    end
end

nextWayPoint ['start'], []
pp $paths if TEST
puts "----------"
puts "Result: #{$paths.size}"