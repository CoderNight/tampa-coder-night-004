require 'spec_helper'
require_relative '../../models/column'

describe Column do
  let(:cave) do
    double('cave', :layout => cave_layout.split("\n"))
  end

  let(:cave_layout) do
"
         ####
##       ####                #
##       ####              ###
######   #######         #####
######   ###########     #####"
  end

  let(:cells)       {cave.layout.map{|r| r[position] || ' '}}
  let(:position)    {rand(1..32)}

  subject(:column) {Column.new(cave, position)}

  describe '#initialize' do
    it "should accept it's parent cave and index" do
      expect{Column.new(cave,position)}.not_to raise_error
    end

    it "should set the cave attribute" do
      expect(column.cave).to eql(cave)
    end

    it "should set the position attribute" do
      expect(column.position).to eql(position)
    end
  end

  describe "#cells" do
    it "should call populate_cells if cells isn't set." do
      column.should_receive(:populate_cells)
      column.cells
    end

    it "should return an array." do
      expect(column.cells).to be_kind_of(Array)
    end
  end

  describe "#populate_cells" do
    it "should populate the cells." do
      expect(column.cells).to eql(cells)
    end
  end

  describe "#left_neighbor" do
    it "should return the column to our left." do
      cave.should_receive(:column_at).with(position - 1)
      column.left_neighbor
    end
  end

  describe "#left_neighbor_water_level" do
    it "should return cells.max if no neighbor is found." do
      column.should_receive(:left_neighbor).any_number_of_times.and_return(nil)
      expect(column.left_neighbor_water_level).to eql(column.cells.length)
    end
  end

  describe "#right_neighbor" do
    it "should return the column to our right." do
      cave.should_receive(:column_at).with(position + 1)
      column.right_neighbor
    end
  end

  describe "#water_level" do
    context "when the water has hit the bottom cell" do
      before do
        column.stub(:cells => [' ',' ',' ','~'])
      end

      it "should return an integer." do
        expect(column.water_level).to be_kind_of(Numeric)
      end

      it "should return the number of units of water." do
        column.cells = [' ',' ',' ','~']
        expect(column.water_level).to eql(1)
      end
    end

    context "when the water has not reached bottom" do
      before do
        column.stub(:cells => ['~','~',nil,nil])
      end

      it "should return '~'." do
        expect(column.water_level).to eql('~')
      end
    end

    context "when there is no water" do
      before do
        column.stub(:cells => [nil,nil,nil,nil])
      end

      it "should return 0." do
        expect(column.water_level).to eql(0)
      end
    end
  end

  describe "#drip" do
    it "should call drip_from_left when source_level is one more than water level." do
      column.should_receive(:water).any_number_of_times.and_return(['~'])
      column.should_receive(:drip_from_left)
      column.drip(2)
    end

    it "should call drip_from_top when source_level is significantly more than water level." do
      column.should_receive(:water).any_number_of_times.and_return(['~'])
      column.should_receive(:drip_from_top)
      column.drip(5)
    end

    it "should return false when we are at water level." do
      column.should_not_receive(:drip_from_top)
      column.should_not_receive(:drip_from_left)
      expect(column.drip(0)).to eql(false)
    end
  end

  describe "#drip_from_top" do
    before do
      column.cells = [' ',' ',' ',' ',' ']
    end

    context "from max height" do
      it "should fill cells with water from the level given down." do
        column.drip_from_top(5)
        expect(column.cells).to eql(['~',' ',' ',' ',' '])
        column.drip_from_top(5)
        expect(column.cells).to eql(['~','~',' ',' ',' '])
        column.drip(5)
        expect(column.cells).to eql(['~','~','~',' ',' '])
        column.drip_from_top(5)
        expect(column.cells).to eql(['~','~','~','~',' '])
        column.drip_from_top(5)
        expect(column.cells).to eql(['~','~','~','~','~'])
      end
    end

    context "from non-max height" do
      it "should fill from the source level down." do
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~',' ',' ',' '])
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~','~',' ',' '])
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~','~','~',' '])
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~','~','~','~'])
      end

      it "should fill from the source level down stopping at a rock." do
        column.cells = [' ',' ',' ','#','#']
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~',' ','#','#'])
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~','~','#','#'])
        column.drip_from_top(4)
        expect(column.cells).to eql([' ','~','~','#','#'])
      end
    end
  end

  describe "#drip_from_left" do
    it "should fill cells with water to the level given." do
      column.cells = [' ',' ',' ',' ','~']
      column.drip(1)
      expect(column.cells).to eql([' ',' ',' ',' ','~'])
    end

    it "should fill cells with water to the level given." do
      column.cells = [' ',' ',' ',' ',' ']
      column.drip(1)
      expect(column.cells).to eql([' ',' ',' ',' ','~'])
      column.drip(2)
      expect(column.cells).to eql([' ',' ',' ','~','~'])
      column.drip(3)
      expect(column.cells).to eql([' ',' ','~','~','~'])
      column.drip(4)
      expect(column.cells).to eql([' ','~','~','~','~'])
      column.drip(5)
      expect(column.cells).to eql(['~','~','~','~','~'])
    end
  end
end
