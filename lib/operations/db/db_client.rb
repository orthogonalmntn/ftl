require 'mongo'
require 'dotenv/load'

module Db
  class DbClient

    attr_reader :client

    def initialize
      @client = Mongo::Client.new([ ENV["MONGODB_URL"] ], :database => ENV["MONGODB_NAME"])
    end

    def self.client
      self.new.client
    end

  end
end
