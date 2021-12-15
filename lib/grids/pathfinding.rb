# frozen_string_literal: true

require 'pqueue'

# A* algorithm
module Grids
  # @private
  # @param came_from [Hash<Node, Node>] came_from hash
  # @param current [Node] current node
  # @return [Array<Node>] reconstructed path
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
  # @param start [Node] start node
  # @param goal [Node] goal node
  # @yield [start, goal] heuristic function
  # @yieldparam start [Node] heuristic start node
  # @yieldparam goal [Node] goal node
  # @return [Array<Node>] the path from start to goal
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def self.a_star(nodes, start, goal, &heuristic)
    came_from = {}

    g_score = {}
    g_score[start] = 0

    f_score = {}
    f_score[start] = heuristic.call(start, goal)

    open_set = PQueue.new([start]) { |a, b| f_score[a] < f_score[b] }

    until open_set.empty?
      current = open_set.pop

      return reconstruct_path(came_from, current) if current == goal

      nodes.neighbors(current).each do |neighbor|
        tentative_g_score = g_score[current] + nodes.weight(current, neighbor)

        next unless !g_score.key?(neighbor) || tentative_g_score < g_score[neighbor]

        came_from[neighbor] = current
        g_score[neighbor] = tentative_g_score
        f_score[neighbor] = g_score[neighbor] + heuristic.call(neighbor, goal)

        open_set << neighbor
      end
    end

    nil
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end
