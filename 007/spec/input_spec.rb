require_relative '../lib/input'
require_relative '../lib/cave'

describe Input do
  describe "#initialize" do
    it "reads the passed in file" do
      file = Object.new
      File.should_receive(:open).with("#{ENV["PWD"]}/support/cave1.txt").and_return(file)
      file.should_receive(:read).and_return("test")
      input = Input.new("cave1.txt")
      input.data.should == "test"
    end

    it "sets the water_limit" do
      input = Input.new("cave1.txt")
      input.water_level.should == 100
    end

    it "assigns cave" do
      input = Input.new("cave1.txt")
      input.cave.should be_a Cave
    end
  end

  describe "#get_data" do
    it "should read the passed in file" do
      file = Object.new
      File.should_receive(:open).with("#{ENV["PWD"]}/support/cave1.txt").and_return(file)
      file.should_receive(:read).and_return("10\ntest")
      input = Input.new
      input.get_data("cave1.txt")
    end
  end

  describe "#data_rows" do
    let(:input) { Input.new }
    it "should return @data_rows if it exists" do
      arr = ["12","test"]
      input.instance_variable_set(:@data_rows, arr)
      input.data_rows.should == arr
    end

    it "should assign @data_rows with the split of data" do
      str = "12\ntest"
      input.instance_variable_set(:@data, str)
      input.data_rows.should == ["12","test"]
    end
  end

  describe "#extract_water_level" do
    let(:input) { Input.new }

    before do
      arr = ["12","test"]
      input.instance_variable_set(:@data_rows, arr)
    end

    it "should return the first value of data_rows" do
      input.extract_water_level.should == 12
    end

    it "should remove the first element which it returns" do
      input.extract_water_level
      input.data_rows.should == ["test"]
    end
  end
end