require "yaml"

module FasterThanLight
  module Generators
    class FromFileGenerator < BaseGenerator

      def initialize
        @file_contents = YAML.load(File.read(File.join("config", "graph.yaml")))
      end

      def generate_planet
        Events::PlanetEvent.new(*planet_from_file)
      end

      def generate_ship
        Events::ShipEvent.new(*ship_from_file)
      end

      def generate_shop
        Events::ShopEvent.new(*shop_from_file)
      end

      private

      def planet_from_file
        planets = @file_contents[:planets]
        chosen_planet = planets[rand(planets.length)]

        [chosen_planet[:name], chosen_planet[:description]]
      end

      def ship_from_file
        ships = @file_contents[:ships]
        chosen_ship = ships[rand(ships.length)]

        [chosen_ship[:name], chosen_ship[:description]]
      end

      def shop_from_file
        shops = @file_contents[:shops]
        chosen_shop = shops[rand(shops.length)]

        [chosen_shop[:name], chosen_shop[:description]]
      end

    end
  end
end
