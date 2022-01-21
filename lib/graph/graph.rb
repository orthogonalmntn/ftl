module FasterThanLight
  module Graph
    class Graph

      attr_reader :start_node

      def initialize(size = 5, width = 3, generator = Generators::LocalGenerator.new)
        @start_node = generate_graph(size, width, generator)
      end

      private

      def generate_graph(size, width, generator)
        start_node = Node.new(position: 1, generator: generator)
        add_nodes_to_node(start_node, size, width, generator, step: 1)
        start_node
      end

      def add_nodes_to_node(node, size, width, generator, step:)
        # (Tree is an acyclic undirected graph)
        return if size == step

        step_nodes = []
        width.times do
          step_nodes << Node.new(position: step + 1, generator: generator)
        end

        node.add_nodes step_nodes
        step += 1

        step_nodes.each do |step_node|
          add_nodes_to_node(step_node, size, width, generator, step: step)
        end
      end

    end
  end
end
