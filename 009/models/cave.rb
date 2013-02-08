require_relative 'column'

class Cave
  attr_accessor :layout, :columns, :default_volume

  def initialize(layout)
    parse_layout(layout)
  end

  def flood(volume = self.default_volume)
    volume.times do
      drip
      puts to_s
    end
  end

  def parse_layout(value)
    self.layout = value.split("\n")

    set_default_volume

    remove_floor
    remove_ceiling
    remove_walls
  end

  def width
    layout.collect(&:length).max
  end

  def columns
    @columns ||= initialize_columns
  end

  def column_at(index)
    columns[index] if index > -1
  end

  def drip
    #columns.each.with_index do |column, index|

    #end

    columns.detect(&:drip)
  end

  def to_s
    [ceiling, *build_layout, floor].join("\n")
  end

  private

  def build_layout
    columns.
      map(&:cells).
      transpose.
      collect{|row| "##{row.join.ljust(width)}#" }
  end

  def ceiling
    "#" * (width + 2)
  end
  alias_method :floor, :ceiling

  def remove_floor
    layout.pop
  end

  def remove_ceiling
    layout.shift
  end

  def remove_walls
    layout.map!{|r| r[1..-2].rstrip}
  end

  def set_default_volume
    return unless layout.first =~ /\d+/
    self.default_volume = layout.shift.to_i
    layout.shift
  end

  def initialize_columns
    Array.new(width) {|position| Column.new(self, position)}
  end
end
