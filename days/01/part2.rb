#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 1
# Part 2

infile = ARGV[0] || 'input.txt'

input = File.readlines(infile).map(&:to_i)

p input.each_cons(4).count { |a, b, c, d| b + c + d > a + b + c }
