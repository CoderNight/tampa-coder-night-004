class Input
  attr_reader :data, :water_level, :cave

  def initialize(filename = nil)
    if filename
      @data = get_data(filename)
      @water_level = extract_water_level
      @cave = Cave.new(data_rows)
    end
  end

  def get_data(filename)
    file = File.open(ENV["PWD"]+"/support/#{filename}")
    @data = file.read
  end

  def data_rows
    @data_rows ||= data.split("\n")
  end

  def extract_water_level
    data_rows.shift.to_i
  end
end