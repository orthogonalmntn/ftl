module Helpers
  module Display
    module_function

    # For methods related to pretty displaying of information on screen
    # https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal

    COLORS_AND_CODES = {
      "red" => 31,
      "green" => 32,
      "yellow" => 33,
      "blue" => 34,
      "light_blue" => 36,
    }

    def wrap_with_chars(char = '-')
      50.times { print char }; puts
      yield
      50.times { print char }; puts
    end

    COLORS_AND_CODES.each_pair do |color, code|
      define_method "in_#{color}" do |arg|
        "\e[#{code}m#{arg}\e[0m"
      end
    end

    # below this the end-codes are different

    def in_blinking(str)
      # not working for some reason:
      "\e[5m#{str}\e[25m"
    end

    def in_italic(str)
      "\e[3m#{str}\e[23m"
    end

  end
end
