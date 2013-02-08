require_relative '../lib/rock_bottom'

describe RockBottom::Cave::PositionHelper do
  PositionHelper = RockBottom::Cave::PositionHelper
  let(:pos) { PositionHelper.new(4) }

  describe '#xy_from_index' do
    it 'converts the index into the correct coordinate pair' do
      pos.xy_from_index(2).should == [2, 0]
      pos.xy_from_index(5).should == [1, 1]
      pos.xy_from_index(6).should == [2, 1]
      pos.xy_from_index(10).should == [2, 2]
      pos.xy_from_index(15).should == [3, 3]
    end
  end

  describe '#index_from_xy' do
    it 'converts the coordinates into the correct index' do
      pos.index_from_xy(2, 0).should == 2
      pos.index_from_xy(1, 1).should == 5
      pos.index_from_xy(2, 1).should == 6
      pos.index_from_xy(2, 2).should == 10
      pos.index_from_xy(3, 3).should == 15
    end
  end

  describe 'relative positions' do
    it 'knows the position below' do
      pos.down(5).should == 9
      pos.down(14).should == 18
    end

    it 'knows the position above' do
      pos.up(5).should == 1
      pos.up(14).should == 10
    end

    it 'knows the position to the left' do
      pos.left(5).should == 4
      pos.left(14).should == 13
    end

    it 'knows the position to the right' do
      pos.right(5).should == 6
      pos.right(14).should == 15
    end
  end
end

