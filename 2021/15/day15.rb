require '../commons.rb'
require 'pp'

$rows = File.readlines(FILE).map(&:strip).map{|x| x.split("").map{|y| y.to_i}}

$directions = ["UP", "DOWN", "RIGHT", "LEFT"]

COLUMNS = $rows[0].size
ROWS = $rows.size
FACTOR =5

def travel x,y, direction
    case direction
    when "LEFT"
        return [x-1,y] unless x-1 < 0
    when "RIGHT"
        return [x+1,y] unless x+1 == $rows[0].size
    when "UP"
        return [x,y+1] unless y+1 == $rows.size
    when "DOWN"
        return [x,y-1] unless y-1 < 0
    else 
        return nil
    end
end


$largeMap = (ROWS*FACTOR).times.map{Array.new(COLUMNS*FACTOR)}
$rows.length.times do |y|
    $rows[0].length.times do |x|
        start = $rows[y][x]
        FACTOR.times do |dx|
            FACTOR.times do |dy|

            val = start
            sy = y + ROWS * dy
            sx = x + COLUMNS * dx
            incrs = dx + dy

            while incrs > 0
            val += 1
            val = 1 if val > 9
            incrs -= 1
            end
            $largeMap[sy][sx] = val
      end
    end
  end
end

def calculateWay map
    fastestPath = Hash.new{|h,k| h[k]=ROWS*COLUMNS*FACTOR*9} 
    #puts "Default value: #{fastestPath[[0,0]]}"
    currentNodes = [[0,0]]
    fastestPath[[0,0]] = 0

    while nextNode = currentNodes.shift   
        x, y = nextNode
        $directions.each do |d|
            nx, ny = travel(x,y,d) 
            next if nx.nil?
            if fastestPath[[x,y]] + map[ny][nx]  < fastestPath[[nx,ny]]
                fastestPath[[nx,ny]] = fastestPath[[x,y]]+map[ny][nx]  
                puts "New fasted way to #{[nx,ny]}: #{fastestPath[[nx,ny]]}" if TEST
                currentNodes.push([nx,ny])
            end
        end
    end 
    return fastestPath
end

$rows = $largeMap

puts SP1
fastestPath = calculateWay $rows
puts "------"
puts "Result: #{fastestPath[[COLUMNS-1, ROWS-1]]}"

puts SP2
puts "Initial map had size #{COLUMNS} / #{ROWS} - new map will have size #{COLUMNS*FACTOR} / #{ROWS*FACTOR}"
puts "------"
puts "Result: #{fastestPath[[COLUMNS*FACTOR-1, ROWS*FACTOR-1]]}"