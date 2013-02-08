class Cave
  def initialize string=nil
    @rows = string.split(/\n/) if string
    @n = 0
  end

  def load filename
    File.open(filename) do |f|
      @n = f.readline.to_i
      f.readline
      @rows = f.read.chomp.split(/\n/)
    end
  end

  def n
    @n
  end

  def to_s
    @rows ? @rows.join("\n") : ""
  end

  def run n=nil
    @rows[1][0] = ' '
    iterate(1, 0, n || @n || 0)
  end

  def calc_depth
    @rows.map {|str| str.chars.to_a }   # convert to array of arrays
    .transpose.map do |column|          # transpose to easily get the depth
      column.count {|cell| cell=='~'}
    end.join(" ")
  end

  private
  
  def iterate row, col, n
    if 0 < n then
      if @rows[row][col] == ' '
        @rows[row][col] = '~'
        n -= 1
        n = iterate(row+1, col, n)
        n = iterate(row, col+1, n)
      end
    end
    n
  end

end