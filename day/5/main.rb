#!/usr/bin/env ruby

seats = {}
highest, id = 0, 0

File.read("input.txt").split.each { |entry|
  
  row, col = 0, 0
  rows = entry[0,7]
  cols = entry[7,9]

  pos = 6
  rows.chars.each { |ch|
    if ch == 'B'
      row += 1 << pos
    end
    pos -= 1
  }

  pos = 2
  cols.chars.each { |ch|
    if ch == 'R'
      col += 1 << pos
    end
    pos -= 1
  }

  id = row * 8 + col
  if id > highest
    highest = id
  end

  if not seats[row]
    seats[row] = []
  end

  seats[row].append(col)
}

puts "highest id: #{highest}"

seats.each { |key, val|
  filled = [0,1,2,3,4,5,6,7]
  if key != 8 and key != 120
    if val.length < 8
      missing = (filled + val - (filled & val))[0]
      id = key * 8 + missing
    end
  end
}

puts "my seat id: #{id}"
