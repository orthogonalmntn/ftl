module FasterThanLight
  class SectorGraph

    include Helpers::Math

    attr_reader :graph

    def initialize
      @graph = initiate_new_graph
    end

    private

    def initiate_new_graph
      new_graph = {}

      (0..10).each do |i|
        elem_of_graph = { i => randomly_generated_event }
        new_graph.merge!(elem_of_graph)
      end

      new_graph
    end

    def randomly_generated_event
      case random(10)
      when 1..3
        Events::PlanetEvent.new
      when 4..5
        Events::ShopEvent.new
      when 6..10
        Events::ShipEvent.new
      when 11
        nil
      end
    end

  end
end