#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 14
# Part 1

require 'aoc'

infile = ARGV[0] || 'input.txt'
input = File.read(infile)
template, rulelines = input.split("\n\n").map(&:strip)
rules = rulelines.lines.map { |line| line.strip.split(' -> ') }.to_h

def substitute(template, rules)
  res = template.chars.first

  template.chars.each_cons(2) do |pair|
    str = pair.join
    res += rules[str] if rules.key?(str)

    res += pair.last
  end

  res
end

10.times do
  template = substitute(template, rules)
end

least, most = template.chars.tally.values.minmax
p most - least
