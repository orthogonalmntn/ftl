module FasterThanLight
  module Components
    class Engine

      attr_reader :type, :str

      ENGINE_LEVELS = {
        1 => { type: :thruster, max_str: 3 },
        2 => { type: :nuclear, max_str: 5 },
        3 => { type: :ion, max_str: 7 },
        4 => { type: :warp, max_str: 10 },
        5 => { type: :dark_matter, max_str: 15 },
      }

      def initialize(engine_level: 1)
        @type = engine_type_from(engine_level)
        @str = engine_str_from(engine_level)
      end

      def upgrade!
        current_level = ENGINE_LEVELS.key(type: @type, max_str: @str)
        return if current_level == ENGINE_LEVELS.keys.max

        next_level = current_level + 1

        @type = ENGINE_LEVELS[next_level][:type]
        @str = ENGINE_LEVELS[next_level][:max_str]
      end

      private

      def engine_type_from(level)
        raise StandardError unless ENGINE_LEVELS.keys.include?(level)

        ENGINE_LEVELS[level][:type]
      end

      def engine_str_from(level)
        raise StandardError unless ENGINE_LEVELS.keys.include?(level)

        ENGINE_LEVELS[level][:max_str]
      end

    end
  end
end
