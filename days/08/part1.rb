#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 8
# Part 1


infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| signals, output = line.split(' | '); [signals, output].map(&:split) }

outputs = input.map(&:last)
ao = outputs.flatten

segmap = { 1 => 2, 4 => 4, 7 => 3, 8 => 7 }

p ao.count { |o| [2, 4, 3, 7].include?(o.length) }
