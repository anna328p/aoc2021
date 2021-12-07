#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 7
# Part 1

infile = ARGV[0] || 'input.txt'
input = File.read(infile).split(',').map(&:to_i)

max_pos = input.max

puts (0..max_pos).map { |x| input.map { n = (x - _1).abs; (n * (n + 1)) / 2 }.sum }.min
