class Node
  attr_reader :prev, :next
  attr_accessor :value

  def initialize(prev, next_node, value)
    @prev = prev
    @next = next_node
    @value = value
  end

  def next=(next_node)
    @next = next_node
    if next_node && next_node.prev != self
      next_node.prev = self
    end
  end

  def prev=(prev)
    @prev = prev
    if prev && prev.next != self
      prev.next = self
    end
  end
end

class DoubleLinkedList
  def initialize(values)
    values = values.split('')
    @head = nil
    prev = nil
    values.each do |value|
      node = Node.new prev, nil, value
      if @head.nil?
        @head = node
      end

      unless prev.nil?
        prev.next = node
      end
      prev = node
    end
  end

  def size
    node = @head
    count = 0
    while node
      count += 1
      node = node.next
    end
    count
  end
end

class Polymer < DoubleLinkedList
  def react!
    no_reactions = false
    until no_reactions
      no_reactions = true
      node = @head
      while node
        if node && node.next && Polymer.reacts?(node.value, node.next.value)
          no_reactions = false
          if node.prev && node.next.next
            # the happy path
            node.prev.next = node.next.next
          elsif node.prev
            # ran into end of list
            node.prev.next = nil
          elsif node.next.next
            # ran into beginning of list
            node = node.next.next
            node.prev = nil
            @head = node
            next
          end
          node = node.prev
        else
          node = node.next
        end
      end
    end
  end

  def self.reacts?(a, b)
    if a.capitalize == b && b.downcase == a
      return true
    elsif a.downcase == b && b.capitalize == a
      return true
    end
    false
  end
end

units = File.open('./input.txt').readlines[0].strip!;

# Part A
polymer = Polymer.new(units)
polymer.react!
puts "Total of #{polymer.size} nodes remain after reaction"


# Part B
min_size = nil;
removed = nil

('a'..'z').each do |unit|
  pattern = Regexp.new(unit, true) # /a/i
  modified_units = units.gsub(pattern, '');

  polymer = Polymer.new(modified_units)
  polymer.react!
  size = polymer.size

  if min_size.nil? || size < min_size
    min_size = size
    removed = unit
  end
end

puts "Minimum size is #{min_size} if #{removed} is removed"
