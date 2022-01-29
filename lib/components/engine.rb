module FasterThanLight
  module Components
    class Engine

      attr_reader :type, :str, :level

      ENGINE_LEVELS = {
        1 => { type: :thruster, max_str: 3 },
        2 => { type: :nuclear, max_str: 5 },
        3 => { type: :ion, max_str: 6 },
        4 => { type: :warp, max_str: 6.5 },
        5 => { type: :dark_matter, max_str: 7.5 },
      }

      def initialize(engine_level: 1)
        @type = engine_type_from(engine_level)
        @str = engine_str_from(engine_level)
        @level = engine_level
      end

      def upgrade!
        return if max_level?

        @level += 1

        @type = ENGINE_LEVELS[@level][:type]
        @str = ENGINE_LEVELS[@level][:max_str]
      end

      def max_level?
        @level == ENGINE_LEVELS.keys.max
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
