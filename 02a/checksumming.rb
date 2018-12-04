ids = File.open('./input.txt').readlines

ids.map! do |id|
  { box_id: id, twice: false, thrice: false }
end

tally = { twice: 0, thrice: 0 }

letters = 'abcdefghijklmnopqrstuvwxyz'.split ''

ids.each do |id|
  letters.each do |letter|
    if id[:twice] and id[:thrice]
      break
    end

    if id[:box_id].count(letter) == 3 and id[:thrice] == false
      id[:thrice] = true;
      next
    elsif id[:box_id].count(letter) == 2 and id[:twice] == false
      id[:twice] = true;
      next
    end
  end

  tally[:twice] += id[:twice] ? 1 : 0
  tally[:thrice] += id[:thrice] ? 1 : 0
end

puts "The checksum is #{tally[:twice] * tally[:thrice]}"
