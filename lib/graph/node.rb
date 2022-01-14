module FasterThanLight
  module Graph
    class Node

      attr_reader :nodes, :position, :event

      def initialize(position:)
        @nodes = []
        @event = generate_random_event
        @position = position
      end

      def add_node(input)
        (nodes << input).flatten!
      end
      alias_method :add_nodes, :add_node

      def last?
        nodes.empty?
      end

      private

      def generate_random_event
        case rand(100)
        when 0..19
          Events::PlanetEvent.new
        when 20..35
          Events::ShopEvent.new
        when 36..70
          Events::ShipEvent.new
        when 70..100
          nil
        end
      end

    end
  end
end
