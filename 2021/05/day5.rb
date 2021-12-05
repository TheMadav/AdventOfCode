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
        while y1 != y2 do
            add2coordinates x1, y1
            y1 += y1<y2 ? 1 : -1
        end
        add2coordinates x2,y2
    elsif y1 == y2
        while x1 != x2 do
            add2coordinates x1, y1
            x1 += x1<x2 ? 1 : -1
        end
        add2coordinates x2,y2
    end
end

puts createDiagram if ARGV[0] == "test"

$coordinates.delete_if {|key, value| value == 1 } 
puts "Result: #{$coordinates.count}"


puts "\n================= TASK 2 ================= "
$coordinates.clear
lines = importData

lines.each do |(x1,y1), (x2,y2)|

    if x1 == x2
        while y1 != y2 do
            add2coordinates x1, y1
            y1 += y1<y2 ? 1 : -1
        end
        add2coordinates x2,y2
    elsif y1 == y2
        while x1 != x2 do
            add2coordinates x1, y1
            x1 += x1<x2 ? 1 : -1
        end
        add2coordinates x2,y2
    else
        j =0 
        while x1 != x2 do
            add2coordinates x1, y1+j
            x1 += x1<x2 ? 1 : -1
            k = y1 > y2 ? -1 : 1 
            j += k
        end
        add2coordinates x2,y2
    end
end
puts createDiagram if ARGV[0] == "test"
$coordinates.delete_if {|key, value| value < 2 } 
puts "Result: #{$coordinates.count}"