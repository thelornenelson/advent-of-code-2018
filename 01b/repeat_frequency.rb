input = File.open '../01a/input.txt'
lines = input.readlines
line = 0
counter = 0
frequencies = { 0 => true }

until false do
  counter += Integer lines[line]

  if frequencies[counter]
    puts "First repeated frequency is #{counter}"
    break
  end

  frequencies[counter] = true
  line += 1

  if line == lines.size
    line = 0
  end
end
