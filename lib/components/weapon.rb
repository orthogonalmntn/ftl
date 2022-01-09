module FasterThanLight
  module Components
    class Weapon

      attr_reader :type, :str

      def initialize(weapon_type:, weapon_str:)
        @type = weapon_type
        @str = weapon_str
      end

    end
  end
end
