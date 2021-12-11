# frozen_string_literal: true

module Grids
  # Node in a square grid
  class SquareGridNode < Node
    attr_accessor :x, :y, :data

    # rubocop: disable Naming/MethodParameterName
    def initialize(x, y, data)
      @x = x
      @y = y
      @data = data
    end
    # rubocop: enable Naming/MethodParameterName
    
    def inspect
      "(#{x}, #{y}): #{data}"
    end
  end

  # Represents a square grid
  # Compatible with the A* algorithm
  class SquareGrid < AbstractNodeSet
    include Enumerable

    def initialize(array)
      nodes = Array.new(array.size) { Array.new(array.first.size) }

      array.each_with_index do |row, y|
        row.each_with_index do |value, x|
          nodes[y][x] = SquareGridNode.new(x, y, value)
        end
      end

      super(nodes)
    end

    def each
      nodes.each_with_index do |row, y|
        row.each_with_index do |node, x|
          yield node, x, y
        end
      end
    end

    # rubocop: disable Naming/MethodParameterName
    def [](x, y)
      nodes[y][x]
    end
    # rubocop: enable Naming/MethodParameterName

    def width
      nodes.first.size
    end

    def height
      nodes.size
    end

    # rubocop: disable Style/NumericPredicate
    # rubocop: disable Metrics/AbcSize
    # rubocop: disable Metrics/PerceivedComplexity
    # rubocop: disable Metrics/CyclomaticComplexity
    # rubocop: disable Metrics/MethodLength
    def neighbors(node, edges: true, corners: false)
      x = node.x
      y = node.y
      neighbors = []

      if edges
        neighbors << self[x - 1, y] if x > 0
        neighbors << self[x + 1, y] if x < width - 1
        neighbors << self[x, y - 1] if y > 0
        neighbors << self[x, y + 1] if y < height - 1
      end

      if corners
        neighbors << self[x - 1, y - 1] if x > 0 && y > 0
        neighbors << self[x + 1, y - 1] if x < width - 1 && y > 0
        neighbors << self[x - 1, y + 1] if x > 0 && y < height - 1
        neighbors << self[x + 1, y + 1] if x < width - 1 && y < height - 1
      end

      neighbors
    end
    # rubocop: enable Style/NumericPredicate
    # rubocop: enable Metrics/AbcSize
    # rubocop: enable Metrics/PerceivedComplexity
    # rubocop: enable Metrics/CyclomaticComplexity
    # rubocop: enable Metrics/MethodLength
  end

  euclidean_heuristic = -> (node, goal) {
    Math.sqrt((node.x - goal.x) ** 2 + (node.y - goal.y) ** 2)
  }

  manhattan_heuristic = -> (node, goal) {
    (node.x - goal.x).abs + (node.y - goal.y).abs
  }
end
