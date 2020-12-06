#!/usr/bin/env ruby

highest = 0

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
}

puts "highest id: %d" % [highest]
