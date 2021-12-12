#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 12
# Part 2

require 'aoc'

class CaveGraph < Grids::AbstractNodeSet
  attr_accessor :traversed, :edges

  def initialize(input)
    @nodes = []
    @edges = []

    @traversed = Set.new

    input.each do |a, b|
      @nodes << a unless @nodes.include?(a)
      @nodes << b unless @nodes.include?(b)
      @edges << [a, b]
    end
  end

  def neighbors(node)
    @edges.select { |a, b| a == node || b == node }.map { |a, b| a == node ? b : a }
  end
end

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| line.strip.split('-') }

graph = CaveGraph.new(input)

def small_cave_twice(visited, cave)
  small_caves = visited.filter { _1.downcase == _1 }.tally
  small_caves[cave]&.then { _1 >= 1 } && small_caves.values.any? { _1 >= 2 }
end

def search(graph, start, target, visited = [], indent = '', orig_start = nil)
  orig_start ||= start
  visited = visited.dup

  visited << start

  paths = []

  graph.neighbors(start).each do |node|
    if node == target
      paths << visited + [node]
      next
    elsif node == orig_start
      next
    elsif node.downcase == node && small_cave_twice(visited, node)
      next
    end

    paths += search(graph, node, target, visited, indent + '  ', orig_start)
  end

  paths
end

puts search(graph, 'start', 'end').count
