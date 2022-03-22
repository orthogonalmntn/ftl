module Helpers
  module Display
    module_function

    COLORS_AND_CODES = {
      "red" => 31,
      "green" => 32,
      "yellow" => 33,
      "blue" => 34,
      "light_blue" => 36,
      "gray" => 37,
    }

    COLORS_AND_CODES.each_pair do |color, code|
      define_method "in_#{color}" do |arg|
        "\e[#{code}m#{arg}\e[0m"
      end
    end

    def wrap_with_chars(char = '-')
      50.times { print char }; puts
      yield
      50.times { print char }; puts
    end

    def based_on_amount(val)
      case
      when val <= 3
        self.in_red val
      when val <= 7
        self.in_yellow val
      when val > 7
        self.in_green val
      end
    end

  end
end
