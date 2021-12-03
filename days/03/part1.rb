#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 3
# Part 1


infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { _1.strip.chars }.transpose

gamma = input.map { |row| row.count('1') > row.count('0') ? '1' : '0' }.join
epsilon = gamma.tr('01', '10')
puts gamma
puts epsilon
puts gamma.to_i(2) * epsilon.to_i(2)
