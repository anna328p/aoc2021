#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 15
# Part 1

require 'aoc'

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { _1.strip.chars.map(&:to_i) }

def inc_all(array, index)
  array.map { |i| (i + index).then { _1 > 9 ? _1 - 9 : _1 } }
end

def expand(array)
  array.map { |row| 5.times.map { |x| inc_all(row, x) }.flatten }
end

def vert_expand(array)
  5.times.map { |x| array.map { |row| inc_all(row, x) } }.flatten(1)
end

full_row = expand(input)
full_map = vert_expand(full_row)

class MyGrid < Grids::SquareGrid
  def weight(current, neighbor)
    neighbor.data
  end
end

grid = MyGrid.new(full_map)

path = Grids.a_star(grid, grid[-1,-1], grid[0,0], &Grids::MANHATTAN_HEURISTIC)
p path.map(&:data)[1..].sum
