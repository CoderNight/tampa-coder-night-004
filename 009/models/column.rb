require_relative 'cave'

class Column
  attr_accessor :cave, :position, :cells

  def initialize(cave, position)
    self.cave, self.position = cave, position
  end

  def cells
    @cells ||= populate_cells
  end

  def water_level
    if water.empty?
      0
    else
      cells.length - cells.rindex{|c| c == '~'}
    end
  end

  def lowest_water_level
    cells.length - (cells.rindex{|c| c == '~'} || 0)
  end

  def highest_water_level
    cells.index{|c| c == '~'} || 0
  end

  def left_neighbor
    cave.column_at(position - 1)
  end

  def right_neighbor
    cave.column_at(position + 1)
  end

  def populate_cells
    cave.layout.map{|row| row[position] || ' ' }
  end

  def drip(source_level = left_neighbor_water_level)
    if source_level > water.length + 1
      drip_from_top(source_level)
    elsif source_level == water.length + 1
      drip_from_left(source_level)
    else
      false
    end
  end

  def drip_from_top(source_level)
    cells.each.with_index do |cell, index|
      next if cell.to_s != ' '
      next if cells.length - index > source_level

      cells[index] = '~'
      return index
    end

    false
  end

  def drip_from_left(source_level)
    cells.reverse_each.with_index do |cell, reversed_index|
      index  = cells.length - reversed_index - 1

      next if cell.to_s != ' '
      next if cells.length - index > source_level

      cells[index] = '~'
      return index
    end

    false
  end

  def left_neighbor_water_level
    if left_neighbor
      left_neighbor.water_level
    else
      cells.length
    end
  end

  def water
    cells.select{|c| c == '~'}
  end

  def rocks
    cells.select{|c| c == '#'}
  end
end
