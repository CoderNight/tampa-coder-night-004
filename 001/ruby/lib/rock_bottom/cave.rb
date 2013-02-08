require 'forwardable'

module RockBottom
  class Cave
    EMPTY   = ' '
    WATER   = '~'
    BARRIER = '#'

    attr_accessor :opening, :positions, :pos

    extend Forwardable
    def_delegators :@pos, :up, :down, :left, :right

    def initialize(rows)
      raise ArgumentError if !rows
      @width = rows[0].length
      @height = rows.length
      @positions = []
      @pos = PositionHelper.new(@width)
      rows.each_with_index do |row, y|
        row.chars.each_with_index do |chr, x|
          index = @pos.index_from_xy(x, y)
          @positions[index] = chr
          @opening = index if chr == WATER
        end
      end
    end

    def at(index)
      if in_bounds(index)
        @positions[index]
      else
        nil
      end
    end

    def fill(index)
      set(index, WATER)
    end

    def set(index, unit)
      if in_bounds(index)
        @positions[index] = unit
      else
        raise IndexError, 'Position outside of cave bounds'
      end
    end

    def in_bounds(index)
      index >= 0 && index < @width * @height
    end

    class PositionHelper < Struct.new(:size)
      def xy_from_index(index)
        y = index / size
        x = index - (size * y)
        [x, y]
      end

      def index_from_xy(x, y)
        size * y + x
      end

      def up(index)
        x, y = xy_from_index(index)
        index = index_from_xy(x, y-1)
      end

      def down(index)
        x, y = xy_from_index(index)
        index_from_xy(x, y+1)
      end

      def left(index)
        x, y = xy_from_index(index)
        index_from_xy(x-1, y)
      end

      def right(index)
        x, y = xy_from_index(index)
        index_from_xy(x+1, y)
      end
    end
  end
end
