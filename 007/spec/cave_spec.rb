require_relative '../lib/cave'

describe Cave do
  describe "#initialize" do
    it "should assign rows" do
      Cave.new(["test"]).rows.should == ["test"]
    end
  end

  describe "add_water" do
    let(:cave) { Cave.new([
                            "################################",
                            "~                              #",
                            "#         ####                 #",
                            "###       ####                ##",
                            "###       ####              ####",
                            "#######   #######         ######",
                            "#######   ###########     ######",
                            "################################"
                          ])
                }
    it "adds x tilda water" do
      cave.add_water(2)
      cave.profile.should == [
                               "################################",
                               "~                              #",
                               "#~~       ####                 #",
                               "###       ####                ##",
                               "###       ####              ####",
                               "#######   #######         ######",
                               "#######   ###########     ######",
                               "################################"
                             ]
    end
  end
end