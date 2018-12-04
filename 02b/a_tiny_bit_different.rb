require "rubygems/text"
# Leverage this hidden method to calculate the Levenshtein Distance between strings
levenshtein = Class.new.extend(Gem::Text).method(:levenshtein_distance)

ids = File.open('../02a/input.txt').readlines

box_1 = nil
box_2 = nil

ids.each_with_index do |id, index|
  checkIndex = index + 1
  found = false
  # Check against all subsuquent IDs, to avoid double checking
  while checkIndex < ids.size
    # We're looking for 2 strings that differ by 1 character, or a Levenshtein distance of 1
    if levenshtein.call(id, ids[checkIndex]) == 1
      found = true
      break
    end
    checkIndex += 1
  end
  if found
    box_1 = id
    box_2 = ids[checkIndex]
    break
  end
end

box_1 = box_1.split ''
box_2 = box_2.split ''

result = ''

box_1.each_with_index do |char, index|
  if char == box_2[index]
    result += char
  end
end

puts "Both boxes have #{result} in common"
