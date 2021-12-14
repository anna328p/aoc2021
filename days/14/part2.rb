#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 14
# Part 2

require 'aoc'

infile = ARGV[0] || 'input.txt'
input = File.read(infile)
template, rulelines = input.split("\n\n").map(&:strip)
rules = rulelines.lines.map { |line| line.strip.split(' -> ') }.to_h

first = template.chars.first
last = template.chars.last

pairs = Hash.new(0).merge template.chars.each_cons(2).map(&:join).tally

40.times do
  new_pairs = pairs.dup

  rules.each do |key, value|
    next unless pairs.key?(key) && pairs[key].positive?

    a, b = key.chars
    temp = pairs[key]
    new_pairs[key] -= temp
    new_pairs[a + value] += temp
    new_pairs[value + b] += temp
  end

  pairs = new_pairs
end

res =
  pairs
  .map { |k, v| k.chars.then { |a, b| [[a, v], [b, v]] } }
  .flatten(1)
  .each_with_object(Hash.new(0)) { |(l, c), h| h[l] += c }

res[first] += 1
res[last] += 1
res.transform_values! { _1 / 2 }
pp(res.values.minmax.then { |min, max| max - min })
