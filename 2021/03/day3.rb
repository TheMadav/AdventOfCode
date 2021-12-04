input = File.readlines('input.txt')
x = (input[0].strip!.length)-1 
gammaB =""
epsiolonB = ""

for i in 0..x do
    counter = 0 
    input.each do |row| 
        counter +=1 unless row[i] == "0"
    end
    if counter > (input.size/2)
        gammaB += "1"
        epsiolonB += "0"
    else
        gammaB += "0"
        epsiolonB += "1"
    end
end
gamma = gammaB.to_i(2)
epsiolon = epsiolonB.to_i(2)
puts "Gamma #{gamma}"
puts "Epsilon #{epsiolon}"
puts "Result #{gamma*epsiolon}"
puts "-------------------"
ogr = input.dup
i = 0
while ogr.size > 1
    counter = 0 
    ogr.each do |row| 
        counter +=1 unless row[i] == "0"
        
    end
    if counter > (ogr.size.to_f/2) 
        ogr.delete_if{|j| j[i] == "0"}
    elsif counter == (ogr.size/2)
        ogr.delete_if{|j| j[i] == "0"}
    else
        ogr.delete_if{|j| j[i] == "1"}      
    end
    i += 1
end
i = 0
csr = input.dup
while csr.size > 1
    counter = 0 
    csr.each do |row| 
        counter +=1 unless row[i] == "0"
    end
    if counter < (csr.size.to_f/2)
        csr.delete_if{|j| j[i] == "0"}
    elsif counter == (csr.size/2) 
       csr.delete_if{|j| j[i] == "1"}
    else
        csr.delete_if{|j| j[i] == "1"}      
    end
    i += 1
end

puts "OGR #{ogr[0].strip!} => #{ogr[0].to_i(2)}"
puts "CSR  #{csr[0].strip!} => #{csr[0].to_i(2)}"
puts "LSR #{ogr[0].to_i(2)*csr[0].to_i(2)}"
