require 'mongo'
require 'dotenv/load'

module Db
  class DbClient

    DB_URL = ENV["MONGODB_URL"]
    DB_NAME = ENV["MONGODB_NAME"]

    attr_reader :client

    def initialize
      @client = Mongo::Client.new([ DB_URL ], :database => DB_NAME)
    end

    def self.client
      self.new.client
    end

  end
end
