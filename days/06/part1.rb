#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 6
# Part 1


infile = ARGV[0] || 'input.txt'
input = File.read(infile).split(',').map(&:to_i)

80.times do
  input.map! do |fish|
    if fish > 0
      fish - 1
    else
      input << 9
      6
    end
  end
end

p input.size
