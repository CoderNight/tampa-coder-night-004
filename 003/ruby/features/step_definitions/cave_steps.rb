Given /^the input file "(.*?)"$/ do |filename|
  @cave = Cave.new
  @cave.load filename
end

When /^I run the program$/ do
  @cave.run
end

Then /^the outcome should look like "(.*?)"$/ do |filename|
  expected = nil
  File.open(filename) do |f|
  	expected = f.read.chomp
  end
  @cave.calc_depth.should == expected
end
