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
      @positions_and_visited_nodes[pos] << num unless num == 0
      @positions_and_visited_nodes[pos].uniq!
    end

    def display_map(pos, infected_nodes)
      visited_nodes = @positions_and_visited_nodes[pos] || []
      display_single_branch(visited_nodes, infected_nodes)
    end

    def display_entire_map(current_position:)
      return if @positions_and_visited_nodes.empty?
      # TODO: improve drawing and positioning of branches...
      wrap_with_chars("***") do
        @positions_and_visited_nodes.each_pair do |k, v|
          print in_blue "Position #{k}"
          if k == current_position
            print "\t<--- YOU ARE HERE\n"
          else
            puts
          end
          display_single_branch(v)
        end

        if current_position > @positions_and_visited_nodes.keys.max
          print in_blue "Position #{current_position}"
          print "\t<--- YOU ARE HERE\n"
          display_single_branch([])
        end
      end

    end

    private

    def display_single_branch(visited_nodes, infected_nodes)
      puts "   #{in_green 'o'}"
      puts " / | \\"

      (1..3).each do |n|
        if visited_nodes.include?(n)
          print "#{in_gray 'o'}"
        # elsif infected_next_nodes.include?(n)
        #   print "#{in_red 'o'}"
        else
          print "#{in_light_blue 'o'}"
        end
        print "  "
      end
      puts "\n1  2  3"
    end

  end
end