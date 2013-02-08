# [[#11] Rock Bottom](http://puzzlenode.com/puzzles/11-hitting-rock-bottom)

## RockBottom

This is my solution for the PuzzleNode Rock Bottom puzzle.

### Via Command Line

```
./rock-bottom support/simple_cave.txt simple_out.txt
./rock-bottom support/complex_cave.txt complex_out.txt
```

### Via Code

```
irb -r './lib/rock_bottom'
flood = RockBottom::Flood.new('support/simple_cave.txt')
flood.flood_cave
flood.print
flood.water_depth_report

flood = RockBottom::Flood.new('support/complex_cave.txt')
flood.flood_cave
flood.print
flood.water_depth_report
```
