module Viauco
  module Admin
    class GeneralSettingsController < Viauco::Admin::BaseController
      include Viauco::Backend::Callbacks

      def edit
        @preferences_security = []
      end

      def update
        params.each do |name, value|
          next unless Viauco::Config.has_preference? name

          Viauco::Config[name] = value
        end

        flash[:success] = Viauco.t(:successfully_updated, resource: Viauco.t(:general_settings))
        redirect_to edit_admin_general_settings_path
      end

      def clear_cache
        Rails.cache.clear
        invoke_callbacks(:clear_cache, :after)
        head :no_content
      end
    end
  end
end
