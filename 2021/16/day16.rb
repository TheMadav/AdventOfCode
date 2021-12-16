require '../commons.rb'
require 'pp'

message  = File.readlines(FILE).map(&:strip).first.chars.map{|x| x.to_i(16).to_s(2).rjust(4, "0")}.join()
$sumVersions = 0
$packets = 0

def convert integer
    return integer.to_i(2).to_i
end

def decode string 
    value = Array.new()
    $packets += 1
    puts "Decoding #{string}" if TEST
    version         = convert string.slice!(0...3)
    type            = convert string.slice!(0...3)
    $sumVersions   += version
    
    puts "Version:  #{version}" if TEST
    puts "Type:     #{type}" if TEST

    if type == 4
        value, string = decode_literal string
    else 
        value, string = decode_operational string, type
    end
end

def decode_operational string, type
    paketValues = []
    lengthID = convert string.slice!(0)
    puts "Length-Indicator: #{lengthID}" if TEST
    if lengthID == 0
        totalLengthSubPackages = convert string.slice!(0...15)
        puts "Total length: #{totalLengthSubPackages}" if TEST
        substring = string.slice!(0...totalLengthSubPackages)
        while substring.include?("1")
            svalue, substring = decode substring
            paketValues << svalue
        end
    else
        totalSubPackages = convert string.slice!(0...11) 
            
        puts "Total sub packages: #{totalSubPackages}" if TEST
        for i in 1..totalSubPackages
            puts "Decoding sub packet #{i} of #{totalSubPackages}" if TEST
            svalue, string = decode string
            paketValues << svalue
        end
    end
    puts "Type #{type} and values: #{paketValues}" if TEST
    case type
    when 0 # Sum paket
        value = paketValues.flatten.sum
    when 1 # Produt Paket
        value = paketValues.flatten.inject(:*)
    when 2 # Min paket
        value = paketValues.flatten.min
    when 3 # max paket
        value = paketValues.flatten.max
    when 5
        if paketValues.size == 2 && paketValues.flatten[0] > paketValues.flatten[1]
            value = 1
        else
            value = 0
        end
    when 6
        if paketValues.size == 2 && paketValues.flatten[0] < paketValues.flatten[1]
            value = 1
        else 
            value = 0
        end
    when 7
        if paketValues.size == 2 && paketValues.flatten[0] == paketValues.flatten[1]
            value = 1
        else 
            value = 0 
        end      
    end
    return [value, string] 
end

def decode_literal string
    value = ""
    loop do
        x = string.slice!(0...5)
        value += x[1...]
        break if x[0] == "0" 
    end
    puts "Value: #{value} => #{convert value}" if TEST
    return [convert(value), string]
end

value = decode message
puts "----"
puts "Result: #{$sumVersions} in #{$packets} packets"
puts "Value: #{value[0]}"