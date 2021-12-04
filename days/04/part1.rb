#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 4
# Part 1

infile = ARGV[0] || 'input.txt'
input = File.read(infile).split("\n\n")
numbers = input[0].split(',').map(&:to_i)

boards = input[1..-1].map { |board| board.lines.map { |line| line.split.map(&:to_i) } }

def matches?(so_far, board)
  res = board.map { |line| line.map { |num| so_far.include? num } }

  res.any? { _1.all? } || res.transpose.any? { _1.all? }
end

so_far = []
res = nil
numbers.each do |num|
  so_far << num
  res = boards.find { matches?(so_far, _1) }
  break if res
end

out = (res.flatten - so_far).sum * so_far.last
puts out
