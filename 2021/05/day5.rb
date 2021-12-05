FILE = ARGV[0] == "test" ? './test.txt' : './input.txt'

def importData
    input = File.readlines(FILE)
    puts "Number of rows: #{input.size}"
    lines = input.map do |line| 
        line =~ /(\d+),(\d+) -> (\d+),(\d+)/
        [[$1.to_i,$2.to_i],[$3.to_i,$4.to_i]]
      end
end

def add2coordinates x, y
    if $coordinates.has_key? :"#{x.to_s}/#{y.to_s}"
        $coordinates[:"#{x}/#{y}"] += 1
    else
        $coordinates[:"#{x}/#{y}"] = 1
    end
end

def createDiagram
    diagram = ""
    for y in 0...10 do
        for x in 0...10 do
            diagram += ($coordinates.has_key? :"#{x}/#{y}")  ? $coordinates[:"#{x}/#{y}"].to_s : "."
        end
        diagram += "\n"
    end
    return diagram
end

puts "================= TASK 1 ================= "
lines = importData
$coordinates = Hash.new

lines.each do |(x1,y1), (x2,y2)|
    if x1 == x2
        for i in y1..y2 do
            add2coordinates x1, i
        end
        for i in y2..y1 do
            add2coordinates x1, i
        end
    elsif y1 == y2
        for i in x1..x2 do
            add2coordinates i, y1
        end
        for i in x2..x1 do
            add2coordinates i, y2
        end
    else
        next
    end
end
# Count points > 2
if ARGV[0] == "test"
    puts createDiagram 
end
$coordinates.delete_if {|key, value| value == 1 } 
puts "Result: #{$coordinates.count}"


puts "\n================= TASK 2 ================= "
$coordinates.clear
lines = importData

lines.each do |(x1,y1), (x2,y2)|

    if x1 == x2
        for i in y1..y2 do
            add2coordinates x1, i
        end
        for i in y2..y1 do
            add2coordinates x1, i
        end
    elsif y1 == y2
        for i in x1..x2 do
            add2coordinates i, y1
        end
        for i in x2..x1 do
            add2coordinates i, y2
        end
    else
        j =0      
        for i in x1..x2 do
            add2coordinates i, y1+j
            k = y1 > y2 ? -1 : 1 
            j += k
        end
        for i in x2..x1 do
            add2coordinates i, y2+j
            k = y2 > y1 ? -1 : 1 
            j += k
        end
    end
end
if ARGV[0] == "test"
    diagram = createDiagram
    puts diagram
end
$coordinates.delete_if {|key, value| value < 2 } 
puts "Result: #{$coordinates.count}"