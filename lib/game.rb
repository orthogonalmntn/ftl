module FasterThanLight
  class Game

    include Helpers::UserInput,
      Helpers::Display

    def initialize(ship)
      @ship = ship
      @map = Map.new
    end

    def run!
      display_dashboard

      # main game loop
      loop do
        @ship.event!
        display_dashboard

        if game_result_check = game_over?
          puts game_result_check
          break
        end

        @map.display_map(@ship.position)

        input = get_input(
          phrase: "Which position to move to [1, 2, 3]?",
          choices: ["1", "2", "3", "quit"]
        )
        break if input == "quit"
        input = input.to_i

        @map.add_next_node(@ship.position, input)
        @ship.move_ship_to_new_position!(input)
      end
    end

    private

    def game_over?
      if @ship.final_position? && !@ship.empty_fuel? && !@ship.destroyed?
        return in_green "Game won!"
      elsif @ship.empty_fuel? || @ship.destroyed? || @ship.final_position?
        return in_red "Game over! :-("
      end

      return false
    end

    def display_dashboard
      wrap_with_chars do
        puts in_light_blue "CURRENT POSITION: #{@ship.position}"
        puts in_light_blue "FUEL: #{@ship.fuel} / HEALTH: #{@ship.health} / SCRAP: #{@ship.scrap}"
      end
    end

  end
end