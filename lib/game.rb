module FasterThanLight
  class Game

    include Helpers::UserInput

    def initialize(ship)
      @ship = ship
    end

    def run!
      @ship.display_dashboard

      # main game loop
      loop do
        @ship.event!
        @ship.display_dashboard

        if game_result_check = game_over?
          puts game_result_check
          break
        end

        input = display(
          phrase: "Which position to move to [1, 2, 3]?",
          choices: ["1", "2", "3", "quit"]
        )
        break if input == "quit"

        @ship.move_ship_to_new_position!(input.to_i)
      end
    end

    private

    def game_over?
      if @ship.final_position? && !@ship.empty_fuel? && !@ship.destroyed?
        return "Game won!"
      elsif @ship.empty_fuel? || @ship.destroyed? || @ship.final_position?
        return "Game over! :-("
      end

      return false
    end

  end
end