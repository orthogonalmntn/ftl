module FasterThanLight
  module Generators
    class BaseGenerator

      def generate_event
        # specific generators can overwrite this distribution for easier/more difficult games
        case rand(100)
        when 0..19
          generate_planet
        when 20..35
          generate_shop
        when 36..70
          generate_ship
        when 70..100
          nil
        end
      end

      ["planet", "ship", "shop"].each do |event_type|
        define_method "generate_#{event_type}" do
          raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end
      end

    end
  end
end
