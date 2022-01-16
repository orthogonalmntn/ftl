module FasterThanLight
  class Map

    include Helpers::Display

    def initialize
      @positions_and_visited_nodes = {}
    end

    def add_next_node(pos, num)
      if @positions_and_visited_nodes[pos] == nil
        @positions_and_visited_nodes[pos] = []
      end
      @positions_and_visited_nodes[pos] << num
    end

    def display_map(pos)
      visited_nodes = @positions_and_visited_nodes[pos] || []
      display_single_branch(visited_nodes)
    end

    private

    def display_single_branch(visited_nodes)
      puts "   #{in_green 'o'}"
      puts " / | \\"
      # Visited nodes are displayed in gray
      # Non-visited nodes are displayed in green
      1..3.times do |t|
        if visited_nodes.include?(t)
          print "#{in_gray 'o'}"
        else
          print "#{in_light_blue 'o'}"
        end
        print "  "
      end
      puts "\n1  2  3"
    end

  end
end