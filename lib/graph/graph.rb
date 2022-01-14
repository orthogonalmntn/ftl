module FasterThanLight
  module Graph
    class Graph

      attr_reader :start_node

      def initialize(size = 5, width = 3)
        # graph.start_node.nodes.first.nodes.first.nodes.first.nodes.first.last?
        @start_node = generate_graph(size, width)
      end

      private

      def generate_graph(size, width)
        # 5 steps, 3 nodes for each step, except for first and last
        # o -> o o o -> o o o -> o o o -> o o o

        start_node = Node.new(position: 1)
        add_nodes_to_node(start_node, size, width, step: 1)
        start_node
      end

      def add_nodes_to_node(node, size, width, step:)
        # Tree structure rather than Graph.
        return if size == step

        step_nodes = []
        width.times do
          step_nodes << Node.new(position: step + 1)
        end

        node.add_nodes step_nodes
        step += 1

        step_nodes.each do |step_node|
          add_nodes_to_node(step_node, size, width, step: step)
        end
      end

    end
  end
end
