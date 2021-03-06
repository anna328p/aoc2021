#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 10
# Part 1

require 'aoc'

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| line.strip.chars }
pp input.first(3)


def check_delimiter_matches(chars)
  stack = []

  delims = { '[' => ']', '{' => '}', '<' => '>', '(' => ')' }

  values = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }

  chars.each do |char|
    if delims.keys.include?(char)
      stack.push(char)
    elsif delims.values.include?(char)
      if delims[stack.last] == char
        stack.pop
      else
        return values[char]
      end
    else
      return false
    end
  end

  return false
end


p input.filter_map { |chars| check_delimiter_matches(chars) }.sum
