require "spec_helper"

describe Cave do
  it "should initialize from file" do
    cave = Cave.new
    cave.load "simple_cave.txt"
    cave.n.should == 100
    cave.to_s.should == (<<-EOF).chomp
################################
~                              #
#         ####                 #
###       ####                ##
###       ####              ####
#######   #######         ######
#######   ###########     ######
################################
EOF
  end
end