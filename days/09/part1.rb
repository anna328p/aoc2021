#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 9
# Part 1

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |l| l.strip.chars.map(&:to_i) }

# Check if we're on the grid edges and return neighbors
def neighbors(x, y, grid)
  neighbors = []

  x > 0 && neighbors << grid[y][x - 1]
  x < grid[y].length - 1 && neighbors << grid[y][x + 1]
  y > 0 && neighbors << grid[y - 1][x]
  y < grid.length - 1 && neighbors << grid[y + 1][x]

  neighbors
end

n = 0
(0..input.length - 1).each do |y|
  (0..input[y].length - 1).each do |x|
    n += input[y][x] + 1 if input[y][x] < neighbors(x, y, input).min
  end
end

puts n
