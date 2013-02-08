require_relative '../lib/rock_bottom'

describe RockBottom::Cave do
  Cave = RockBottom::Cave
  let(:input) { [
      "################################",
      "~                              #",
      "#         ####                 #",
      "###       ####                ##",
      "###       ####              ####",
      "#######   #######         ######",
      "#######   ###########     ######",
      "################################"
    ]
  }
  let(:cave) { Cave.new(input) }

  describe '#initialize' do
    it 'takes the input of the initial cave state' do
      expect { Cave.new }.to raise_error
      expect { Cave.new(input) }.to_not raise_error
    end

    it 'sets up a position helper to the size of the cave width' do
      cave.pos.should be_kind_of(Cave::PositionHelper)
      cave.pos.size.should == cave.instance_variable_get(:@width)
    end

    it 'sets the opening to the first instance of water' do
      cave.at(32).should == Cave::WATER
      cave.opening.should == 32
    end
  end

  describe '#at' do
    it 'returns the current unit state at that position' do
      cave.at(0).should == Cave::BARRIER
      cave.at(32).should == Cave::WATER
      cave.at(73).should == Cave::EMPTY
      cave.at(74).should == Cave::BARRIER
    end

    it 'returns INVALID_SPACE for invalid spaces' do
      cave.at(-1).should == nil
      cave.at(300).should == nil
    end
  end

  describe '#set' do
    it 'sets the unit state at that position' do
      cave.at(73).should == Cave::EMPTY
      cave.set(73, Cave::WATER)
      cave.at(73).should == Cave::WATER
    end

    it 'raises an error when setting outside of cave bounds' do
      error = 'Position outside of cave bounds'
      expect { cave.set(-1, Cave::WATER)}.to raise_error(error)
      expect { cave.set(300, Cave::WATER)}.to raise_error(error)
    end
  end

  describe '#in_bounds' do
    it 'returns true when index in bounds' do
      cave.in_bounds(3).should == true
      cave.in_bounds(80).should == true
    end

    it 'returns false when index not in bounds' do
      cave.in_bounds(-5).should == false
      cave.in_bounds(400).should == false
    end
  end

  it 'delegates positional methods to the position helper' do
    position = 201
    cave.at(position).should == RockBottom::Cave::EMPTY
    cave.at(cave.down(position)).should == RockBottom::Cave::BARRIER
    cave.at(cave.right(position)).should == RockBottom::Cave::BARRIER
  end
end
