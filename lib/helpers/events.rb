module Helpers
  module Events

    EVENT_ACTION_KEYS = [
      :fuel_gain,
      :fuel_loss,
      :ship_damage,
      :scrap_gain,
      :scrap_loss,
      :health_gain,
    ]

    EventResponse = Struct.new(*EVENT_ACTION_KEYS, :action_resolver, keyword_init: true)

  end
end
