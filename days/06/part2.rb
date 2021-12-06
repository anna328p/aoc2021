#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 6
# Part 2

infile = ARGV[0] || 'input.txt'
input = File.read(infile).split(',').map(&:to_i).tally
pool = Array.new(9, 0)

input.each do |k, v|
  pool[k] = v
end

iter_count = 256

iter_count.times do
  births = pool.shift
  pool.push(births)
  pool[6] += births
end

p pool.sum
