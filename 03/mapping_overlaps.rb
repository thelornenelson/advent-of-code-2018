input = File.open('./input.txt').readlines

# parse input
claims = input.map do |line|
  match_pattern = /#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/
  matches = match_pattern.match line

  {
    id: Integer(matches[:id]),
    x: Integer(matches[:x]),
    y: Integer(matches[:y]),
    max_x: Integer(matches[:x]) + Integer(matches[:width]),
    max_y: Integer(matches[:y]) + Integer(matches[:height]),
  }
end

the_grid = []

# plot all the claims on grid
def plot_on_grid(claim, grid)
  (claim[:y]...claim[:max_y]).each do |y|
    if grid[y].nil?
      grid[y] = []
    end

    row = grid[y]

    (claim[:x]...claim[:max_x]).each do |x|
      row[x].nil? ? row[x] = 1 : row[x] += 1
    end
  end
  grid
end

claims.each do |claim|
  the_grid = plot_on_grid claim, the_grid
end

# interate over grid to find any overlaps
overlaps = 0

the_grid.each do |row|
  unless row.nil?
    row.each do |x|
      unless x.nil?
        if x > 1 then overlaps += 1 end
      end
    end
  end
end

puts "Total #{overlaps} square inches of overlap"

# Now find the sole survivor!
def overlap?(claim, grid)
  found_overlap = false;
  (claim[:y]...claim[:max_y]).each do |y|
    row = grid[y]

    (claim[:x]...claim[:max_x]).each do |x|
      if row[x] > 1
        found_overlap = true
        break
      end
    end
    break if found_overlap
  end
  found_overlap
end

claims.each do |claim|
  unless overlap? claim, the_grid
    puts "Claim #{claim[:id]} is unique"
  end
end
