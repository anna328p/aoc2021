#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 1
# Part 1

infile = ARGV[0] || 'input.txt'

input = File.readlines(infile).map(&:to_i)

p input.each_cons(2).count { |a, b| b > a }
