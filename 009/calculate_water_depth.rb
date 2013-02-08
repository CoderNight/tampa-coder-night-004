require_relative 'models/cave'

if $PROGRAM_NAME == __FILE__
  cave = Cave.new(File.read('input_files/simple_cave.txt'))
  cave.flood
end
