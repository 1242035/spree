require 'rails/engine'

module Viauco
  module Api
    class Engine < Rails::Engine
      isolate_namespace Viauco
      engine_name 'viauco_api'

      Rabl.configure do |config|
        config.include_json_root = false
        config.include_child_root = false

        # Motivation here it make it call as_json when rendering timestamps
        # and therefore display miliseconds. Otherwise it would fall to
        # JSON.dump which doesn't display the miliseconds
        config.json_engine = ActiveSupport::JSON
      end

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer 'viauco.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %w[
          viauco/api/all*
        ]
      end

      initializer 'viauco.api.environment', before: :load_config_initializers do |_app|
        Viauco::Api::Config = Viauco::ApiConfiguration.new
        Viauco::Api::Dependencies = Viauco::ApiDependencies.new
      end

      initializer 'viauco.api.checking_migrations' do
        Migrations.new(config, engine_name).check
      end

      def self.root
        @root ||= Pathname.new(File.expand_path('../../..', __dir__))
      end
    end
  end
end
