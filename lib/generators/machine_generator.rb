require "faraday"

module FasterThanLight
  module Generators
    class MachineGenerator < BaseGenerator

      # It takes way too long to generate for a world of size 10x3
      # Should reconsider using this generator on a step-by-step basis
      # i.e. generate the next 9 branches when the ship moves by 1 position

      SERVICE_URL = "http://127.0.0.1:8000"

      def generate_planet
        Events::PlanetEvent.new(*planet_from_generator)
      end

      def generate_ship
        Events::ShipEvent.new(*ship_from_generator)
      end

      def generate_shop
        Events::ShopEvent.new(*shop_from_generator)
      end

      private

      def planet_from_generator
        resp = conn.get("/planet")

        planet_name = resp.body["name"]
        planet_description = resp.body["description"]
        [planet_name, planet_description]
      end

      def ship_from_generator
        resp = conn.get("/ship")

        ship_name = resp.body["name"]
        ship_description = resp.body["description"]
        [ship_name, ship_description]
      end

      def shop_from_generator
        resp = conn.get("/shop")

        shop_name = resp.body["name"]
        shop_description = resp.body["description"]
        [shop_name, shop_description]
      end

      def conn
        Faraday.new(SERVICE_URL) do |c|
          c.request :json
          c.headers["Accept"] = "application/json"
          c.headers["Content-Type"] = "application/json"
          c.response :json
          c.adapter :net_http
        end
      end

    end
  end
end
