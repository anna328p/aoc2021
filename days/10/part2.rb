#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 10
# Part 2

require 'aoc'

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| line.strip.chars }

def median(array)
  return nil if array.empty?

  sorted = array.sort
  len = sorted.length
  sorted[(len - 1) / 2]
end

def check_delimiter_matches(chars)
  stack = []

  delims = { '[' => ']', '{' => '}', '<' => '>', '(' => ')' }

  values = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }

  chars.each do |char|
    if delims.keys.include?(char)
      stack.push(char)
    elsif delims.values.include?(char)
      return false unless delims[stack.last] == char

      stack.pop
    else
      return false
    end
  end

  vals = stack.reverse.map { |char| delims[char] }
  
  points = 0
  vals.each do |val|
    points *= 5
    points += values[val]
  end

  points
end


p median(input.filter_map { |chars| check_delimiter_matches(chars) })
