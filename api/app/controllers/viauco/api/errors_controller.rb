module Viauco
  module Api
    class ErrorsController < ActionController::Base
      def render_404
        render 'viauco/api/errors/not_found', status: 404
      end
    end
  end
end
