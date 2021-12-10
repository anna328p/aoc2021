# frozen_string_literal: true

require 'set'

# A* algorithm
module Grids
  # @private
  # @param came_from [Hash<Node, Node>] the came_from hash
  # @param current [Node] the current node
  # @return [Array<Node>] the path
  def self.reconstruct_path(came_from, current)
    total_path = [current]
    while came_from.key?(current)
      current = came_from[current]
      total_path << current
    end
    total_path
  end

  # A* search.
  # @param nodes [AbstractNodeSet] a set of nodes
  # @param start [Node] the start node
  # @param goal [Node] the goal node
  # @yield [start, goal] heuristic function
  # @yieldparam start [Node] the start node
  # @yieldparam goal [Node] the goal node
  # @return [Array<Node>] the path from start to goal
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def self.a_star(nodes, start, goal, &heuristic)
    open_set = Set.new([start])
    came_from = {}

    g_score = {}
    g_score[start] = 0

    f_score = {}
    f_score[start] = heuristic.call(start, goal)

    until open_set.empty?
      current = open_set.min_by { f_score[_1] }

      return reconstruct_path(came_from, current) if current == goal

      open_set.delete(current)

      nodes.neighbors(current).each do |neighbor|
        tentative_g_score = g_score[current] + nodes.weight(current, neighbor)

        next unless !g_score.key?(neighbor) || tentative_g_score < g_score[neighbor]

        came_from[neighbor] = current
        g_score[neighbor] = tentative_g_score
        f_score[neighbor] = g_score[neighbor] + heuristic.call(neighbor, goal)
        open_set.add(neighbor)
      end
    end

    nil
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end