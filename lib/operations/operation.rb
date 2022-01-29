require "virtus"

module Operations
  class Operation
    include Virtus.model

    def self.call(...)
      new(...).call
    end

  end
end
