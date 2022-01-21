module FasterThanLight
  module Generators
    class LocalGenerator < BaseGenerator

      def generate_planet
        Events::PlanetEvent.new
      end

      def generate_ship
        Events::ShipEvent.new
      end

      def generate_shop
        Events::ShopEvent.new
      end

    end
  end
end

