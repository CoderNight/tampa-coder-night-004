class CavePuzzle
  attr_accessor :cave, :remaining_water

  WATER = "~"
  AIR   = " "
  EARTH = "#"
  FIRE  = "*"

  def initialize(new_cave, remaining_water)
    @cave = new_cave
    @remaining_water = remaining_water

    flow(0, starting_column)
  end

  def self.initialize_from_io(io)
    remaining_water = io.gets.chomp.to_i
    io.gets
    cave = io.each_line.map { |line| line.chomp.chars.to_a }

    self.new(cave, remaining_water)
  end

  def inspect
    cave.map(&:join).join("\n")
  end

  def to_s
    cave.transpose.map(&:join).map { |line| line.include?("#{WATER} ") ? WATER : line.count(WATER) }.join(" ")
  end

  def starting_column
    cave.index { |line| line[0] == WATER }
  end

  def more_water?
    self.remaining_water > 0
  end

  def air?(row,col)
    cave[row][col] == AIR
  end

  def flow(row, col)
    cave[row][col] = WATER
    self.remaining_water = self.remaining_water - 1

    [[row+1,col],[row,col+1]].each { |row, col| flow(row, col) if more_water? && air?(row,col) }
  end
end

# Change this to 'p' to see the cave
puts CavePuzzle.initialize_from_io(STDIN)

