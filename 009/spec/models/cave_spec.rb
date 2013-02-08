require 'spec_helper'
require_relative '../../models/cave'

describe Cave do
  let(:cave_layout) do
"
         ####
##       ####                #
##       ####              ###
######   #######         #####
######   ###########     #####"
  end

  let(:raw_cave_layout) do
    [ceiling,
     *cave_layout_array.map{|r| "##{r.ljust(cave_width)}#"},
     floor].join("\n")
  end

  let(:ceiling) { '#' * (cave_width + 2)}
  let(:floor)   { ceiling }

  let(:cave_width)        {cave_layout_array.collect(&:length).max}
  let(:fill_volume)       {100}
  let(:cave_layout_array) {cave_layout.split("\n")}
  let(:input_file)        {"#{fill_volume}\n\n#{raw_cave_layout}"}

  subject(:cave) {Cave.new(input_file)}

  describe '#initialize' do
    it "should accept an ascii cave layout" do
      expect{Cave.new(input_file)}.not_to raise_error
    end

    it "should save cave layout into layout attribute" do
      expect(cave.layout).to eql(cave_layout_array)
    end

    it "should save the default volume into default_volume attr" do
      expect(cave.default_volume).to eql(fill_volume)
    end
  end

  describe '#flood' do
    let(:volume) {rand(1..150)}

    it "should use the default volume from the layout." do
      expect{cave.flood}.not_to raise_error
    end

    it "should accept a volume of water." do
      expect{cave.flood(volume)}.not_to raise_error
    end

    it "should call drip for each unit of water." do
      cave.should_receive(:drip).exactly(volume).times
      cave.flood(volume)
    end

    it "should fill the cave with water." do
      pending
      expect{cave.flood}.to change{cave.to_s}
    end
  end

  describe "#parse_layout" do
    before do
    end

    it "should remove the volume from the raw layout." do
      cave.parse_layout(input_file)
      expect(cave.default_volume).to eql(fill_volume)
    end

    it "should set the layout (excluding volume) from the raw layout." do
      cave.parse_layout(input_file)
      expect(cave.layout.join("\n")).to eql(cave_layout)
    end
  end

  describe "#width" do
    it "should return the width of the current layout" do
      expect(cave.width).to eql(cave_width)
    end
  end

  describe "#columns" do
    let(:width) {rand(1..100)}

    before do
      cave.stub(:width => width)
    end

    it "should call #width to get the number of columns." do
      cave.should_receive(:width).and_return(width)
      expect(cave.columns.length).to eql(width)
    end

    it "should initialize the columns" do
      cave.columns = nil
      expect(cave.columns).to be_kind_of(Array)
    end

    it "should create an array of Column instances." do
      cave.columns.each do |column|
        expect(column).to be_instance_of(Column)
      end
    end
  end

  describe "#column_at" do
    it "should return the column at the given index." do
      expect(cave.column_at(1)).to eql(cave.columns[1])
    end

    it "should return nil if the column doesn't exist." do
      expect(cave.column_at(-1)).to be_nil
    end
  end

  describe "#drip" do
    it "should call #drip on the first column." do
      cave.columns.first.should_receive(:drip)
      cave.drip
    end
  end

  describe "#to_s" do
    it "should iterate and print the current columns." do
      expect(cave.to_s).to eql(raw_cave_layout)
    end
  end
end
