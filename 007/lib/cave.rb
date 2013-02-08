class Cave
  attr_reader :rows

  def initialize(arr = [])
    @rows = arr
  end

  def add_water(amount = 1)
    amount.times do
      add_drop
    end
  end

  def add_drop
    (1..rows.length-2).each do |row|
      if (rows[row].index(" ") < rows[row+1].index(" "))
        rows[row][rows[row].index(" ")] = "~"
        break
      else
        next
      end
    end
  end

  def output
    array_of_arrays.map {|column| measure_depth(column)}.join(" ")
  end

  def measure_depth(column)
    column.count("~")
  end

  def array_of_arrays
    rows.map {|row| row.split("")}
  end

  def profile
    rows.each do |row|
      p row
    end
  end
end