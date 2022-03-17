module FasterThanLight
  module Graph
    class Node

      attr_reader :nodes, :position, :generator, :id
      attr_accessor :event

      @@id_incrementor = 0

      def initialize(position:, generator:)
        @nodes = []
        @event = generator.generate_event
        @position = position
        @generator = generator
        @id = @@id_incrementor
        @@id_incrementor += 1
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
