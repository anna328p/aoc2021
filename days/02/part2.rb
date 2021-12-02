#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 2
# Part 1


infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| a, b = line.split; [a, b.to_i] }

x = 0
aim = 0
depth = 0

input.each do |op, val|
  case op
  when 'forward'
    x += val
    depth += aim * val
  when 'down'
    aim += val
  when 'up'
    aim -= val
  end
end

puts depth * x
