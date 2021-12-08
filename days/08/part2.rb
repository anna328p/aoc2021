#!/usr/bin/env ruby

# frozen_string_literal: true

require 'set'

# Advent of Code 2021
# Day 8
# Part 2

Line = Struct.new(:signals, :outputs)

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map do |line|
  signals, output = line.split(' | ')
  Line.new(*[signals, output].map { |n| n.split.map(&:chars) })
end

#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....
#
#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

aseg = {
  0 => 'abcefg',
  1 => 'cf',
  2 => 'acdeg',
  3 => 'acdfg',
  4 => 'bcdf',
  5 => 'abdfg',
  6 => 'abdefg',
  7 => 'acf',
  8 => 'abcdefg',
  9 => 'abcdfg'
}

absolute_segments = aseg.transform_values(&:chars)

asi = aseg.invert

def tally_segments(list)
  list.map(&:to_a).flatten.tally
end

def unique_by_value(hash)
  vals = hash.values
  hash.dup.delete_if { |_, v| vals.count(v) > 1 }
end

absolute_counts = tally_segments(absolute_segments.values)

unique_absolute_counts = unique_by_value(absolute_counts).invert

known_counts = { 1 => 2, 4 => 4, 7 => 3, 8 => 7 }
known_digits_absolute = known_counts.transform_values { |count| absolute_segments.values.find { _1.size == count } }

input.map do |line|
  scrambled_counts = tally_segments(line.signals)

  unique_scrambled_counts = unique_by_value(scrambled_counts).invert

  known_segments = unique_absolute_counts.map { |count, char| [unique_scrambled_counts[count], char] }.to_h

  known_digits_scrambled = known_counts.transform_values { |count| line.signals.find { _1.size == count } }

  known_map = known_digits_scrambled.values.zip(known_digits_absolute.values).to_h

  loop do
    rest = known_map.map { |s, a| [s - known_segments.keys, a - known_segments.values] }.to_h

    one_to_one = rest.select { |_, v| v.size == 1 }

    one_to_one.each { |k, v| known_segments[k[0]] = v[0] }

    if one_to_one.empty?
      break
    end
  end

  line.outputs.map { asi[_1.join.tr(*known_segments.to_a.transpose.map(&:join)).chars.sort.join] }.map(&:to_s).join.to_i
end.sum.then { puts _1 }
