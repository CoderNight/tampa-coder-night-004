Gem::Specification.new do |s|
  s.name        = 'cave'
  s.version     = '0.0.0'
  s.date        = '2013-01-27'
  s.summary     = "Water simulation in a cave."
  s.executables = "cave"
  s.authors     = ["Anonymous"]
  s.description = "Simulates water flowing into a cave.  This gem includes an executeable which can output the depths or an ASCII graph of the end result after n iterations.  The executable expects a filename.  An example can be found in the data directory"
  s.files       = ["bin/cave", "lib/cave.rb", "data/complex_cave.txt", "data/simple_cave.txt", "data/simple_out.txt", "README.md"]
end