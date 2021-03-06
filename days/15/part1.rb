#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 15
# Part 1

require 'aoc'

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { _1.strip.chars.map(&:to_i) }

class MyGrid < Grids::SquareGrid
  def weight(current, neighbor)
    neighbor.data
  end
end

grid = MyGrid.new(input)

path = Grids.a_star(grid, grid[-1,-1], grid[0,0], &Grids::MANHATTAN_HEURISTIC)
p path.map(&:data)[1..].sum
