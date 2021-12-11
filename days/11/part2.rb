#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 11
# Part 1

require 'aoc'

Value = Struct.new(:energy, :flashed)

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| line.strip.chars.map { Value.new(_1.to_i, false) } }

grid = Grids::SquareGrid.new(input)

def flash(grid, node)
  return unless node.data.energy > 9 && node.data.flashed == false

  neighbors = grid.neighbors(node, corners: true)

  node.data.flashed = true

  neighbors.each do |n|
    n.data.energy += 1
    flash(grid, n)
  end
end

1.step do |n|
  grid.nodes.each do |row|
    row.each do |node|
      node.data.energy += 1
    end
  end

  grid.nodes.each do |row|
    row.each do |node|
      flash(grid, node)
    end
  end

  grid.nodes.each do |row|
    row.each do |node|
      if node.data.flashed
        node.data.flashed = false
        node.data.energy = 0
      end
    end
  end

  if grid.nodes.all? { |row| row.all? { |node| node.data.energy.zero? } }
    puts n
    break
  end
end
