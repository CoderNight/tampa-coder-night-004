#!/usr/bin/env ruby

class Cave
  attr_accessor :units
  attr_accessor :atlas

  def initialize(input)
    @atlas = []
    File.open(input) do |file|
      @units = Integer(file.gets)
      file.seek(1, IO::SEEK_CUR)
      file.lines do |line|
        atlas << line.chomp.split(//)
      end
    end
    flow(0, 1)
  end

  def flow(x, y)
    if units > 0
      fill(x, y)
      flow(x, y+1) if empty?(x, y+1)
      flow(x+1, y) if empty?(x+1, y)
    end
  end

  def fill(x, y)
    atlas[y][x] = Elements::WATER
    self.units -= 1
  end

  def empty?(x, y)
    atlas[y][x] == Elements::AIR
  end

  def print
    atlas.each do |line|
      puts line.join
    end
  end

  def measure
    depths = []
    atlas.transpose.each do |column|
      depth = column.count(Elements::WATER)
      if depth > 0 && column[column.rindex(Elements::WATER) + 1] != Elements::EARTH
        depth = Elements::WATER
      end
      depths << depth
    end
    puts depths.join(" ")
  end

  module Elements
    EARTH = "#"
    WATER = "~"
    AIR = " "
    # FIRE = "*"
    # HEART = "@"
  end
end

if ARGV[0]
  Cave.new(ARGV[0]).measure
else
  puts "No input given. Usage: `ruby #{$0} filename`.\n"
end
