module FasterThanLight
  module Generators
    class LocalGenerator < BaseGenerator

      def generate_planet
        Events::PlanetEvent.new(planet_name, planet_description)
      end

      def generate_ship
        Events::ShipEvent.new(ship_name, ship_description)
      end

      def generate_shop
        Events::ShopEvent.new(shop_name, shop_description)
      end

      private

      def planet_name
        names = [
          'Planet X',
          'Planet Y',
          'Planet Z'
        ]

        names[rand(names.length)]
      end

      def planet_description
        descriptions = [
          'A dry planet with no signs of life',
          'An ocean planet with shiny sun-streaks on its massive waves',
          'Rocky world, with scattered signs of primitive civilization'
        ]

        descriptions[rand(descriptions.length)]
      end

      def ship_name
        names = [
          'Galactica',
          'Zembulon',
          'Antiqon'
        ]

        names[rand(names.length)]
      end

      def ship_description
        descriptions = [
          'A big sturdy ship with gleaming weapons aimed at you',
          'Stealthy bomber from an unknown sector',
          'Small but dangerous-looking spacecraft'
        ]

        descriptions[rand(descriptions.length)]
      end

      def shop_name
        names = [
          'Hedys Shop',
          'Tin X',
          'Veeropulos'
        ]

        names[rand(names.length)]
      end

      def shop_description
        descriptions = [
          'A small shop with not much in the way of exotic merchandise',
          'Big, expensive shop',
          'The only shop in this sector'
        ]

        descriptions[rand(descriptions.length)]
      end

    end
  end
end
