require "virtus"
require_relative "db/db_client"

module Operations
  class Operation
    include Virtus.model

    def self.call(...)
      new(...).call
    end

  end
end
