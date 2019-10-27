module Viauco
  module TestingSupport
    module UrlHelpers
      def viauco
        Viauco::Core::Engine.routes.url_helpers
      end
    end
  end
end
