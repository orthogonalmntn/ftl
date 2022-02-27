module FasterThanLight
  module Graph
    class Node

      attr_reader :nodes, :position, :generator
      attr_accessor :event

      def initialize(position:, generator:)
        @nodes = []
        @event = generator.generate_event
        @position = position
        @generator = generator
      end

      def add_node(input)
        (nodes << input).flatten!
      end
      alias_method :add_nodes, :add_node

      def last?
        nodes.empty?
      end

    end
  end
end
