#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 5
# Part 1

Point = Struct.new(:x, :y)

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map do |l|
  p1, p2 = l.strip.split(' -> ')
  p1 = Point.new(*p1.split(',').map(&:to_i))
  p2 = Point.new(*p2.split(',').map(&:to_i))
  [p1, p2]
end

horiz = input.filter { |p1, p2| p1.y == p2.y }.map { |p| p.sort_by(&:x) }
vert = input.filter { |p1, p2| p1.x == p2.x }.map { |p| p.sort_by(&:y) }

diag = input.filter { |p1, p2| p1.x != p2.x && p1.y != p2.y }.map { |p| p.sort_by(&:x) }

xmax = input.max_by { |p1, p2| [p1.x, p2.x].max }.map(&:x).max
ymax = input.max_by { |p1, p2| [p1.y, p2.y].max }.map(&:y).max

field = Array.new(ymax + 1) { Array.new(xmax + 1) { 0 } }

horiz.each do |p1, p2|
  (p1.x..p2.x).each do |x|
    field[p1.y][x] += 1
  end
end

vert.each do |p1, p2|
  (p1.y..p2.y).each do |y|
    field[y][p1.x] += 1
  end
end

diag.each do |s1, s2|
  dir = s2.y <=> s1.y

  (s1.x..s2.x).each do |x|
    field[s1.y + dir * (x - s1.x)][x] += 1
  end
end

p field.flatten.filter { _1 > 1 }.count
