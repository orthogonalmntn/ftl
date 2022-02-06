require "faraday"

module FasterThanLight
  module Generators
    class MachineGenerator < BaseGenerator

      # It takes way too long to generate for a world of size 10x3
      # Should reconsider using this generator on a step-by-step basis
      # i.e. generate the next 9 branches when the ship moves by 1 position

      SERVICE_URL = "http://127.0.0.1:8000" # move to dotenv

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

      ["planet", "ship", "shop"].each do |event|
        define_method "#{event}_from_generator" do
          resp = conn.get("/#{event}")

          [resp.body["name"], resp.body["description"]]
        rescue Faraday::ConnectionFailed => e
          [nil, nil]
        end
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
