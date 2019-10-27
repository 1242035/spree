module Viauco
  module TestingSupport
    module Preferences
      # Resets all preferences to default values, you can
      # pass a block to override the defaults with a block
      #
      # reset_viauco_preferences do |config|
      #   config.track_inventory_levels = false
      # end
      #
      def reset_viauco_preferences(&config_block)
        Viauco::Preferences::Store.instance.persistence = false
        Viauco::Preferences::Store.instance.clear_cache

        config = Rails.application.config.viauco.preferences
        configure_viauco_preferences &config_block if block_given?
      end

      def configure_viauco_preferences
        config = Rails.application.config.viauco.preferences
        yield(config) if block_given?
      end

      def assert_preference_unset(preference)
        find("#preferences_#{preference}")['checked'].should be false
        Viauco::Config[preference].should be false
      end
    end
  end
end
