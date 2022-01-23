module FasterThanLight
  module Components
    class Weapon

      attr_reader :type, :str

      WEAPON_LEVELS = {
        1 => { type: :torpedo, max_str: 3 },
        2 => { type: :nuclear, max_str: 5 },
        3 => { type: :ion, max_str: 7 },
        4 => { type: :positron, max_str: 10 },
        5 => { type: :dark_energy, max_str: 15 },
      }

      def initialize(weapon_level: 1)
        @type = weapon_type_from(weapon_level)
        @str = weapon_str_from(weapon_level)
      end

      def upgrade!
        current_level = WEAPON_LEVELS.key(type: @type, max_str: @str)
        return if current_level == WEAPON_LEVELS.keys.max

        next_level = current_level + 1

        @type = WEAPON_LEVELS[next_level][:type]
        @str = WEAPON_LEVELS[next_level][:max_str]
      end

      private

      def weapon_type_from(level)
        raise StandardError unless WEAPON_LEVELS.keys.include?(level)

        WEAPON_LEVELS[level][:type]
      end

      def weapon_str_from(level)
        raise StandardError unless WEAPON_LEVELS.keys.include?(level)

        WEAPON_LEVELS[level][:max_str]
      end

    end
  end
end
