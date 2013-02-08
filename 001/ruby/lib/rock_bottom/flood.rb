module RockBottom
  class Flood
    attr_accessor :units, :cave

    def initialize(input_path)
      lines = File.readlines(input_path).map { |line| line.gsub(/\n/, '') }
      @units = lines.shift.to_i
      lines.shift if lines[0] == ''
      @cave = Cave.new(lines)
      @current_position = @cave.opening
    end

    def current_position
      @current_position
    end

    def print
      width = cave.pos.size
      height = cave.positions.length / width
      puts ""
      height.times do |y|
        start_row = width * y
        end_row = start_row + width - 1
        puts cave.positions[start_row..end_row].join('')
      end
      puts ""
    end

    def water_depth_report
      water_depths.join(' ')
    end

    def water_depths
      counts = {}
      cave.pos.size.times do |column|
        counts[column] = 0
      end
      cave.positions.each_with_index do |unit, index|
        column, _ = cave.pos.xy_from_index(index)
        if unit == Cave::WATER
          counts[column] += 1
        elsif unit == Cave::EMPTY && counts[column] != 0
          counts[column] = Cave::WATER
        end
      end
      counts.values
    end

    def flood_cave
      @units -= 1 # subtract initial starting unit
      while units > 0 do
        flow
      end
    end

    def flow
      if cave.at(cave.down(current_position)) == Cave::EMPTY
        flow_down
      elsif cave.at(cave.right(current_position)) == Cave::EMPTY
        flow_right
      else
        flow_up
      end
      tick
    end

    def flow_up
      rise
      move_towards_flow_source
      cave.fill(current_position)
    end

    def flow_down
      flow_into_position(cave.down(current_position))
    end

    def flow_right
      flow_into_position(cave.right(current_position))
    end

    def tick
      @units -= 1 unless @units == 0
    end

    private

    def rise
      while cave.at(cave.up(current_position)) != Cave::EMPTY do
        @current_position = cave.up(current_position)
      end
      @current_position = cave.up(current_position)
    end

    def move_towards_flow_source
      while cave.at(cave.left(current_position)) == Cave::EMPTY do
        @current_position = cave.left(current_position)
      end
    end

    def flow_into_position(position)
      @current_position = position
      cave.fill(current_position)
    end
  end
end
