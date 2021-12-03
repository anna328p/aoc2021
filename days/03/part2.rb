#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 3
# Part 1

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { _1.strip.chars }

def criterion(col, type)
  case type
  when :o2
    col.count('0') > col.count('1') ? '0' : '1'
  when :co2
    col.count('1') < col.count('0') ? '1' : '0'
  end
end

def find_match(input, type, index = 0)
  tr = input.transpose

  cr = criterion(tr[index], type)

  res = input.filter { _1[index] == cr }
  if res.size == 1
    res[0]
  else
    find_match(res, type, index + 1)
  end
end

o2_rating = find_match(input, :o2).join.to_i(2)
co2_rating = find_match(input, :co2).join.to_i(2)

puts o2_rating * co2_rating
