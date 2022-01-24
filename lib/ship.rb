module FasterThanLight
  class Ship

    attr_reader :fuel, :health, :scrap, :weapon, :engine, :position

    def initialize(sector_graph:)
      @fuel = 10
      @health = 10
      @scrap = 10
      @weapon = Components::Weapon.new
      @engine = Components::Engine.new
      @current_node = sector_graph.start_node
      @previous_nodes = [@current_node]
    end

    def move_ship_to_new_position!(input)
      return if final_position?

      if input == 0
        if first_position?
          puts "Can't go back any further!"
          return
        else
          # go back one node
          @current_node = @previous_nodes.last
          @previous_nodes -= [@previous_nodes.last]
        end
      else
        @previous_nodes << @current_node
        @current_node = @current_node.nodes[(input - 1)]
      end

      @fuel -= 1
    end

    def event!
      if event = @current_node.event
        event_response = event.resolve_event!(ship: self)
        handle_event_response(event_response)

        # destroy already-passed event:
        #   -> maybe we should allow some events to exist a while longer (e.g. planets?)
        @current_node.event = nil
      else
        puts "There seems to be nothing here."
      end
    end

    def position
      @current_node.position
    end

    def final_position?
      @current_node.last?
    end

    def first_position?
      position == 1
    end

    def empty_fuel?
      @fuel <= 0
    end

    def destroyed?
      @health <= 0
    end

    def handle_event_response(event_response)
      return unless event_response

      # Fuel
      @fuel += event_response.fuel_gain if event_response.fuel_gain
      @fuel -= event_response.fuel_loss if event_response.fuel_loss

      # Scrap
      @scrap += event_response.scrap_gain if event_response.scrap_gain
      @scrap -= event_response.scrap_loss if event_response.scrap_loss

      # Health
      @health += event_response.health_gain if event_response.health_gain
      @health -= event_response.ship_damage if event_response.ship_damage
    end
    alias_method :handle_outcome, :handle_event_response

  end
end
