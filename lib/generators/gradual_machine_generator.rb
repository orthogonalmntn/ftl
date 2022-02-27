require "faraday"
require "jwt"

module FasterThanLight
  module Generators
    class GradualMachineGenerator < BaseGenerator

      SERVICE_URL = ENV["GENERATOR_SERVICE_URL"]
      SECRET_KEY = ENV["JWT_SECRET_KEY"]
      ALGORITHM = "HS512"

      def generate_planet
        "Planet"
      end

      def generate_real_planet
        Events::PlanetEvent.new(*planet_from_generator)
      end

      def generate_ship
        "Ship"
      end

      def generate_real_ship
        Events::ShipEvent.new(*ship_from_generator)
      end

      def generate_shop
        "Shop"
      end

      def generate_real_shop
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
          c.headers["X-Token"] = token
          c.response :json
          c.adapter :net_http
        end
      end

      def token
        JWT.encode(
          payload,
          SECRET_KEY,
          ALGORITHM,
        )
      end

      def payload
        {
          exp: Time.now.to_i + 120
        }
      end

    end
  end
end
