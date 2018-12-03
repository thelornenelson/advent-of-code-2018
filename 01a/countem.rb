input = File.open './input.txt'
counter = 0

input.readlines.each do |line|
  counter += Integer line
end

puts "Resulting frequency is #{counter}"
