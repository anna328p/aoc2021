#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 13
# Part 2

infile = ARGV[0] || 'input.txt'
input = File.read(infile)

pointlines, foldlines = input.split("\n\n")

points = pointlines.lines.map do |line|
  line.split(',').map(&:to_i)
end

folds = foldlines.lines.map do |line|
  line[11..-1].split('=').then { |a, b| [a, b.to_i] }
end

max_x = points.map { _1[0] }.max
max_y = points.map { _1[1] }.max

field = Array.new(max_y + 1) { Array.new(max_x + 1) { ' ' } }

points.each do |x, y|
  field[y][x] = '#'
end

def fold_y(field, line)
  top = field[0..(line - 1)]
  bottom = field[(line + 1)..-1]

  th = top.length

  bottom.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      top[th - y - 1][x] = cell if cell == '#'
    end
  end

  top
end

def fold_x(field, line)
  left = field.map { |row| row[0..(line - 1)] }
  right = field.map { |row| row[(line + 1)..-1] }

  lw = left.first.length

  right.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      left[y][lw - x - 1] = cell if cell == '#'
    end
  end

  left
end

folds.each do |dir, coord|
  case dir
  when 'x'
    field = fold_x(field, coord)
  when 'y'
    field = fold_y(field, coord)
  end
end

field.map { _1.join }.each { puts _1 }
