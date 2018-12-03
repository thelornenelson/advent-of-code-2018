ids = File.open('./input.txt').readlines

ids.map! do |id|
  { id: id, twice: false, thrice: false }
end

letters = 'abcdefghijklmnopqrstuvwxyz'.split ''

ids.each do |id|
  letters.each do |letter|
    # check if 3 in ID
    # check for 2
    # if 3 and 2 found, then break
  end
end
