module Helpers
  module UserInput
    module_function

    def display(phrase:, choices:)
      loop do
        print "#{phrase} [#{choices.join('/')}] => "
        user_input = gets.chomp

        if choices.include? user_input
          return user_input
        else
          puts "(Please choose a valid input)"
        end
      end
    end

  end
end