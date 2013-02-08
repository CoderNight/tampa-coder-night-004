# Coder Night, February 2013

Problem: [Hitting Rock Bottom][1]

Three solutions, one in C and two in Ruby.

## Running the C solution.

    cd c
    make
    ./cave ../caves/complex_cave.txt

## Running the Ruby solution.

    cd ruby
    ruby cave.rb ../caves/complex_cave.txt

## Running the OpenGL solution.

Based on the Ruby solution, but animated using OpenGL/Gosu.

    cd opengl
    bundle install
    ruby cave.rb ../caves/simple_cave.txt

## Checking the solutions

To check the ruby solution:

    rake test

To check the c solution:

    make test

[1]: http://puzzlenode.com/puzzles/11-hitting-rock-bottom