class Cave
  attr_reader :cave, :cave_file, :water_units

  def initialize(file)
    @cave_file   = import_cave_file(file)
    @water_units = water_units
    @cave        = build_cave
  end

  # Import cave file and remove newline characters
  # from each line.
  #
  # @param [String] file location/name
  # @return [Array] of each file line as an element
  def import_cave_file(file)
    begin
      cave_file = File.readlines(file)
    rescue => e
      puts "Error trying to load file: #{e.message}"
      exit 1
    end

    cave_file.each {|i| i.chomp!}
  end

  # Get the amount of water units from
  # cave file. Expecting it to be on the first line.
  #
  # @return [Integer]
  def water_units
    @cave_file[0].to_i
  end

  # Build a new array of arrays from the cave elements
  # in the cave file.
  #
  # @return [Array]
  def build_cave
    new_cave_array = []
    @cave_file[2..-1].each {|i| new_cave_array << i.split(//)}

    @cave = new_cave_array
  end

  # Output the cave
  #
  # @return [String]
  def print_cave
    @cave.collect {|i| i.join('')}
  end

  # ** logic issue **
  # ** not correctly filling in cave **
  #
  # Add water to the cave.
  #
  # @return [Array]
  def add_water_to_cave
    @cave[0].length.times do |column|
      @cave.length.times do |row|
        break if @water_units == 0
        if @cave[row][column].match /(#|~)/ then
          next
        else
          @cave[row][column] = "~"
          @water_units -= 1
        end
      end
    end until @water_units == 0
  end

  # Get the amount of water
  # for each column.
  #
  # @return [String]
  def count_water_depth
    water_depth = []
    @cave[0].length.times do |column|
      depth_count = 0
      @cave.length.times do |row|
        depth_count +=1 if @cave[row][column].match /~/
      end
      water_depth << depth_count
    end

    water_depth.join(' ')
  end
end
