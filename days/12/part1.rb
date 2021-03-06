#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 12
# Part 1

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

  def weight(a, b)
    # check if b is a small node
    if b.downcase == b
      return Float::INFINITY
    else
      return 1
    end
  end
end

infile = ARGV[0] || 'input.txt'
input = File.readlines(infile).map { |line| line.strip.split('-') }

graph = CaveGraph.new(input)

def search(graph, start, target, visited = [], indent = '')
  visited = visited.dup

  visited << start

  paths = []

  graph.neighbors(start).each do |node|
    if node == target
      paths << visited + [node]
      next
    elsif visited.include?(node) && node.downcase == node
      next
    end

    paths += search(graph, node, target, visited, indent + '  ')
  end

  paths
end

pp search(graph, 'start', 'end').count
