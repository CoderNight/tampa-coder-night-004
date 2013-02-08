Feature: Calculate cave depth
  In order to map out the cave
  As a spelunker
  I want measure the depth of the

  Scenario: Simple cave
    Given the input file "simple_cave.txt"
    When I run the program
    Then the outcome should look like "simple_out.txt"
