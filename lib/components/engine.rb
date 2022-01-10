module FasterThanLight
  module Components
    class Engine

      attr_reader :type, :str

      def initialize(engine_type:, engine_str:)
        @type = engine_type
        @str = engine_str
      end

    end
  end
end
