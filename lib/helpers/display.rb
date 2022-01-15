module Helpers
  module Display
    module_function

    # For methods related to pretty displaying of information on screen
    # https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal

    def wrap_with_chars(char = '-')
      50.times { print char }; puts
      yield
      50.times { print char }; puts
    end

    def in_red(str)
      "\e[31m#{str}\e[0m"
    end

    def in_green(str)
      "\e[32m#{str}\e[0m"
    end

    def in_yellow(str)
      "\e[33m#{str}\e[0m"
    end

    def in_blue(str)
      "\e[34m#{str}\e[0m"
    end

    def in_light_blue(str)
      "\e[36m#{str}\e[0m"
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
