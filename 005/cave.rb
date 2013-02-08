class Cave
  WATER, ROCK, AIR = '~', '#', ' '

  # Set water_amount, grid and initial water coordiantes based on input file
  def initialize(file)
    lines = File.readlines(file)
    # Amount of water to fill cave: 99 for simple, 2460 for complex
    @water_amount = lines.shift.to_i - 1
    # Parse the lines into an grid array
    # Get an array of coordinates for water, coordinates start from the top left
    @cave_grid, @water_coordinates = set_grid_and_coordinates(lines)
  end

  def set_grid_and_coordinates(lines)
    line_count = 0
    coordinates = []
    grid = lines.map do |line|
      line.chomp!
      next if line.empty?
      char_position = 0
      line.each_char do |char|
        coordinates << [line_count,char_position] if char.eql?(WATER)
        char_position += 1
      end
      line_count += 1
      line.split(//)
    end
    return grid.compact, coordinates
  end

  # fill until the water is gone
  def fill_with_water
    while @water_amount > 0
      coordinates = @water_coordinates.last
      row, column = coordinates.first, coordinates.last
      if @cave_grid[row + 1][column].eql?(AIR)
        row += 1
        @cave_grid[row][column] = WATER
        @water_coordinates << [row, column]
        @water_amount -= 1
      else
        if @cave_grid[row][column + 1].eql?(ROCK)
          @water_coordinates.pop
        else
          column += 1
          coordinates[1] = column
          @cave_grid[row][column] = WATER
          @water_amount -= 1
        end #end if @cave_grid
      end #end if flowable?
    end #end while @water_amount
  end

  # Return the water levels for each column of the cave
  def water_levels
    #Subtract 1 because last line is a wall.
    number_of_columns = @cave_grid.first.size - 1
    number_of_rows = @cave_grid.size
    (0...number_of_columns).map do |column|
      depth = 0
      (0...number_of_rows).each do |row|
        if @cave_grid[row][column].eql?(AIR) and depth > 0
          depth = WATER
          break
        end
        depth += 1 if @cave_grid[row][column].eql?(WATER)
      end #end number_of_rows
      depth
    end.join(" ") #end number_of_columns
  end

  # Display cave as a viewable graphic
  def to_s
    @cave_grid.collect{|row| row.join }.join("\n")
  end
end

# To run from command line: ruby cave.rb <cave file>
if __FILE__ == $0
  cave = Cave.new(ARGV[0])
  cave.fill_with_water
  puts cave
  puts cave.water_levels
end