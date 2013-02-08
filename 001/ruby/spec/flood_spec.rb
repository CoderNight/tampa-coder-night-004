require_relative '../lib/rock_bottom'

describe RockBottom::Flood do
  let(:input_path) {
    File.join(File.dirname(__FILE__), '../support/simple_cave.txt')
  }
  let(:complex_input_path) {
    File.join(File.dirname(__FILE__), '../support/complex_cave.txt')
  }
  let(:sample_output) {
    '1 2 2 4 4 4 4 6 6 6 1 1 1 1 4 3 3 4 4 4 4 5 5 5 5 5 2 2 1 1 0 0'
  }
  let(:complex_output) {
    '1 12 1 5 8 8 9 10 17 17 18 20 24 24 24 24 24 24 32 32 32 32 32 32 32 32 9 5 1 1 9 11 29 30 32 32 32 32 32 22 20 19 18 13 10 10 8 4 4 3 3 19 19 20 21 23 23 24 24 26 32 32 32 32 32 32 32 22 22 22 21 21 21 6 6 2 1 1 1 1 1 1 1 32 30 30 30 8 8 5 5 2 2 2 8 19 19 19 20 21 26 26 27 28 28 29 29 30 30 30 30 30 30 30 30 30 30 30 30 30 17 16 15 15 15 11 8 8 6 6 6 1 1 1 1 ~ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0'
  }
  let(:flood) { RockBottom::Flood.new(input_path) }

  context 'simple example' do
    it 'floods the cave with water' do
      flood.flood_cave
      # enable print to see output
      #flood.print
      flood.water_depth_report.should == sample_output
    end
  end

  context 'complex example' do
    it 'floods the cave with water' do
      flood = RockBottom::Flood.new(complex_input_path)
      flood.flood_cave
      # enable print to see output
      #flood.print
      flood.water_depth_report.should == complex_output
    end
  end

  describe '#initialize' do
    it 'reads the water units from the input file' do
      flood.units.should == 100
    end

    it 'initializes the cave' do
      flood.cave.should be_an_instance_of(RockBottom::Cave)
    end

    it 'sets the current position to the first water unit in the cave' do
      flood.cave.at(32).should == RockBottom::Cave::WATER
      flood.current_position.should == 32
    end
  end

  describe '#tick' do
    it 'decrements the amount of units of water left' do
      flood.units.should == 100
      flood.tick
      flood.units.should == 99
    end
  end

  describe '#flow' do
    let(:cave) { flood.cave }

    it 'starts processing ticks' do
      flood.should_receive(:tick)
      flood.flow
    end

    it 'flows down if space available' do
      flood.instance_variable_set(:@current_position, 33)
      cave.at(cave.down(flood.current_position)).should == RockBottom::Cave::EMPTY
      flood.should_receive(:flow_down)
      flood.flow
    end

    it 'flows right if down blocked and right available' do
      flood.instance_variable_set(:@current_position, 65)
      cave.at(cave.down(flood.current_position)).should == RockBottom::Cave::BARRIER
      cave.at(cave.right(flood.current_position)).should == RockBottom::Cave::EMPTY
      flood.should_receive(:flow_right)
      flood.flow
    end

    it 'rises if down and right are both blocked' do
      flood.instance_variable_set(:@current_position, 201)
      cave.set(199, RockBottom::Cave::WATER)
      cave.set(200, RockBottom::Cave::WATER)
      cave.set(201, RockBottom::Cave::WATER)
      cave.at(cave.down(flood.current_position)).should == RockBottom::Cave::BARRIER
      cave.at(flood.current_position).should == RockBottom::Cave::WATER
      cave.at(cave.left(flood.current_position)).should == RockBottom::Cave::WATER
      cave.at(cave.right(flood.current_position)).should == RockBottom::Cave::BARRIER
      cave.at(cave.up(flood.current_position)).should == RockBottom::Cave::EMPTY
      flood.should_receive(:flow_up)
      flood.flow
    end
  end

  describe '#flow_down' do
    before(:each) do
      flood.instance_variable_set(:@current_position, 33)
    end

    it 'fills the space below with water' do
      orig_position = flood.current_position
      down_position = flood.cave.down(orig_position)
      flood.cave.at(down_position).should == RockBottom::Cave::EMPTY
      flood.flow_down
      flood.current_position.should_not == orig_position
      flood.current_position.should == down_position
      flood.cave.at(flood.current_position).should == RockBottom::Cave::WATER
    end
  end

  describe '#flow_right' do
    before(:each) do
      flood.instance_variable_set(:@current_position, 199)
      flood.cave.fill(flood.current_position)
    end

    it 'fills the space to the right with water' do
      orig_position = flood.current_position
      right_position = flood.cave.right(orig_position)
      flood.cave.at(right_position).should == RockBottom::Cave::EMPTY
      flood.flow_right
      flood.current_position.should_not == orig_position
      flood.current_position.should == right_position
      flood.cave.at(flood.current_position).should == RockBottom::Cave::WATER
    end
  end

  describe '#flow_up' do
    before(:each) do
      flood.instance_variable_set(:@current_position, 201)
      flood.cave.fill(flood.current_position)
      flood.cave.fill(167)
      flood.cave.fill(199)
      flood.cave.fill(200)
    end

    it 'climbs to the top and fills the leftmost spot' do
      orig_position = flood.current_position
      expected_new_position = 168
      flood.cave.at(orig_position).should == RockBottom::Cave::WATER
      flood.cave.at(flood.cave.left(orig_position)).should == RockBottom::Cave::WATER
      flood.cave.at(flood.cave.down(orig_position)).should == RockBottom::Cave::BARRIER
      flood.cave.at(flood.cave.right(orig_position)).should == RockBottom::Cave::BARRIER
      flood.flow_up
      flood.current_position.should_not == orig_position
      flood.current_position.should == expected_new_position
      flood.cave.at(flood.current_position).should == RockBottom::Cave::WATER
    end
  end

  describe '#water_depths' do
    it 'returns an array of the depths of each column in the cave' do
      depths = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      flood.water_depths.should == depths
      [33, 65, 66, 98, 130].each { |position| flood.cave.fill(position) }
      depths = [1,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      flood.water_depths.should == depths
    end
  end
end

