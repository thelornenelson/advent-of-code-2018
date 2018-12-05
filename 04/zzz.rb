input = File.open('./input.txt').readlines

input.sort! do |a, b|
  matcher = /\[(.+)\]/
  matcher.match(a)[1] <=> matcher.match(b)[1]
end

current_guard = nil
input.map! do |line|
  matcher = /:(?<minute>\d\d).+((#(?<guard_id>\d+))|(?<action>wake|sleep))/
  matches = matcher.match line
  current_guard = matches[:guard_id] || current_guard
  {
    guard_id: Integer(current_guard),
    minute: matches[:minute].to_i,
    action: matches[:action],
  }
end

guards = {}

input.each_with_index do |line, index|
  unless guards[line[:guard_id]]
    guards[line[:guard_id]] = { asleep: [] }
  end

  guard = guards[line[:guard_id]]

  if line[:action] == 'sleep'
    wake_minute = input[index + 1][:minute]
    (line[:minute]...wake_minute).each do |minute|
      if guard[:asleep][minute]
        guard[:asleep][minute] += 1
      else
        guard[:asleep][minute] = 1
      end
    end
  end
end

sleepiest_guard = { guard_id: nil, mins_asleep: 0, sleepiest_minute: 0 }

guards.each do |guard_id, value|
  mins_asleep = value[:asleep].reduce(0) do |sum, minutes|
    unless minutes.nil?
      sum += minutes
    end
    sum
  end
  if mins_asleep > sleepiest_guard[:mins_asleep]
    sleepiest_guard[:guard_id] = guard_id
    sleepiest_guard[:mins_asleep] = mins_asleep
  end
end

max_minutes_asleep = 0
guards[sleepiest_guard[:guard_id]][:asleep].each_with_index do |minutes, minute|
  if not minutes.nil? and minutes > max_minutes_asleep
    max_minutes_asleep = minutes
    sleepiest_guard[:sleepiest_minute] = minute
  end
end

puts sleepiest_guard

most_regular_guard = { guard_id: nil, max_asleep: 0, max_minute: 0 }

guards.each do |guard_id, guard|
  asleep = guard[:asleep]

  if asleep.nil?
    next
  end

  max_asleep = 0
  max_minute = 0
  asleep.each_with_index do |minutes, minute|
    if not minutes.nil? and minutes > max_asleep
      max_asleep = minutes
      max_minute = minute
    end
  end
  guard[:max_asleep] = max_asleep
  guard[:max_minute] = max_minute

  if max_asleep > most_regular_guard[:max_asleep]
    most_regular_guard = {
      guard_id: guard_id,
      max_asleep: max_asleep,
      max_minute: max_minute,
    }
  end
end

puts most_regular_guard
