class Cave
  attr_reader :water, :maxdepth
  # read cave input file
  def initialize(cavefile)
    lines = File.readlines(cavefile)

    # total water given
    @water = lines.first.chomp.to_i

    # calculate maximum possible depth
    @maxdepth = lines.count - 4

    # move to the opening of the cave
    until lines.first[0] == "~"
        lines.shift
    end

    # make map of cave
    build_matrix(lines)
  end

  def build_matrix(lines)
      @matrix = lines.map do |line|
        line.chomp!
      end
  end

  def flow(row, col)
      unless @water == 0
          puts "row is #{row}"
          puts "col is #{col}"
          puts @matrix[row][col]
        case @matrix[row][col]
        when " "
            puts "flowing down"
            flow_down(row,col)
        when "#"
            puts "flowing right"
            flow_right(row,col)
        end
      else
          puts "water gone"
      end
  end

  def flow_down(row, col)
      puts "space"
      @water -= 1
      row += 1 unless row == @maxdepth
      flow(row,col)
  end

  def flow_right(row,col)
      puts "rock"
      @water -= 1
      col += 1
      row -= 1
      flow(row,col)
  end

end

if __FILE__ == $0
  cave = Cave.new(ARGV[0])
  cave.flow(0,1)
  puts "total water: \t\t #{cave.water}"
  puts "max possible depth: \t #{cave.maxdepth}"
end