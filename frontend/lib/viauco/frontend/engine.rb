module Viauco
  module Frontend
    class Engine < ::Rails::Engine
      config.middleware.use 'Viauco::Frontend::Middleware::SeoAssist'

      # Prevent XSS but allow text formatting
      config.action_view.sanitized_allowed_tags = %w(a b del em i ins mark p small strong sub sup)
      config.action_view.sanitized_allowed_attributes = %w(href)

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer 'viauco.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %w[
          viauco/frontend/all*
        ]
      end

      initializer 'viauco.frontend.environment', before: :load_config_initializers do |_app|
        Viauco::Frontend::Config = Viauco::FrontendConfiguration.new
      end
    end
  end
end
