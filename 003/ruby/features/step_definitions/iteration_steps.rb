Given /^a cave that looks like$/ do |string|
  @cave = Cave.new string
end

When /^I iterate (\d+) times$/ do |n|
  @cave.run n.to_i
end

Then /^the cave should look like$/ do |string|
  @cave.to_s.should == string
end