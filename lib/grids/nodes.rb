# frozen_string_literal: true

module Grids
  # Abstract class for a node.
  # @abstract
  class Node
  end

  # Abstract class for a set of nodes.
  # To use, implement #neighbors and #weight.
  # @abstract
  class AbstractNodeSet
    attr_accessor :nodes

    def initialize(nodes)
      @nodes = nodes
    end

    def neighbors(node)
      raise NotImplementedError
    end

    def weight(node1, node2)
      raise NotImplementedError
    end
  end
end
