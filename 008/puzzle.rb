require_relative "lib/cave"

cave_file = ARGV[0] || "puzzle_files/simple_cave.txt"

puzzle  = Cave.new(cave_file)

puzzle.add_water_to_cave

puts puzzle.print_cave

puts puzzle.count_water_depth

