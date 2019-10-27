require 'viauco/api/responders/rabl_template'

module Viauco
  module Api
    module Responders
      class AppResponder < ActionController::Responder
        include RablTemplate
      end
    end
  end
end
