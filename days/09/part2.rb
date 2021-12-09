#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 9
# Part 2

require 'set'

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |l| l.strip.chars.map(&:to_i) }

def neighbor_coords(x, y, grid)
  neighbors = []

  x > 0 && neighbors << [x - 1, y]
  x < grid[y].length - 1 && neighbors << [x + 1, y]
  y > 0 && neighbors << [x, y - 1]
  y < grid.length - 1 && neighbors << [x, y + 1]

  neighbors
end

# Check if we're on the grid edges and return neighbors
def neighbors(x, y, grid)
  neighbor_coords(x, y, grid).map { |nx, ny| grid[ny][nx] }
end

def low_points(grid)
  low_points = []

  (0..grid.length - 1).each do |y|
    (0..grid[y].length - 1).each do |x|
      low_points << [x, y] if grid[y][x] < neighbors(x, y, grid).min
    end
  end

  low_points
end

# Find regions of the grid at this point surrounded by 9s
def find_basin(x, y, grid)
  return nil if grid[y][x] == 9

  points = Set.new
  points << [x, y]

  loop do
    count = 0
    points.dup.each do |px, py|
      neighbor_coords(px, py, grid).each do |n|
        nx, ny = n
        if grid[ny][nx] != 9
          count += 1 unless points.include?(n)
          points << n
        end
      end
    end
    break if count.zero?
  end

  points
end

lp = low_points(input)
basins = lp.map { |x, y| find_basin(x, y, input) }

p basins.map(&:length).max(3).inject(:*)
