module Viauco
  module TestingSupport
    module ControllerRequests
      extend ActiveSupport::Concern

      included do
        routes { Viauco::Core::Engine.routes }
      end

      def viauco_get(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_get is deprecated and will be removed in Viauco 4.1.
          Please use get, params: {}
        DEPRECATION
        process_viauco_action(action, parameters, session, flash, 'GET')
      end

      # Executes a request simulating POST HTTP method and set/volley the response
      def viauco_post(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_post is deprecated and will be removed in Viauco 4.1.
          Please use post, params: {}
        DEPRECATION
        process_viauco_action(action, parameters, session, flash, 'POST')
      end

      # Executes a request simulating PUT HTTP method and set/volley the response
      def viauco_put(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_put is deprecated and will be removed in Viauco 4.1.
          Please use put, params: {}
        DEPRECATION
        process_viauco_action(action, parameters, session, flash, 'PUT')
      end

      # # Executes a request simulating PATCH HTTP method and set/volley the response
      def viauco_patch(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_patch is deprecated and will be removed in Viauco 4.1.
          Please use patch, params: {}
        DEPRECATION
        process_viauco_action(action, parameters, session, flash, 'PATCH')
      end

      # Executes a request simulating DELETE HTTP method and set/volley the response
      def viauco_delete(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_delete is deprecated and will be removed in Viauco 4.1.
          Please use delete, params: {}
        DEPRECATION
        process_viauco_action(action, parameters, session, flash, 'DELETE')
      end

      def viauco_xhr_get(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_xhr_get is deprecated and will be removed in Viauco 4.1.
        DEPRECATION
        process_viauco_xhr_action(action, parameters, session, flash, :get)
      end

      def viauco_xhr_post(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_xhr_post is deprecated and will be removed in Viauco 4.1.
        DEPRECATION
        process_viauco_xhr_action(action, parameters, session, flash, :post)
      end

      def viauco_xhr_put(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_xhr_put is deprecated and will be removed in Viauco 4.1.
        DEPRECATION
        process_viauco_xhr_action(action, parameters, session, flash, :put)
      end

      def viauco_xhr_patch(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_xhr_patch is deprecated and will be removed in Viauco 4.1.
        DEPRECATION
        process_viauco_xhr_action(action, parameters, session, flash, :patch)
      end

      def viauco_xhr_delete(action, parameters = nil, session = nil, flash = nil)
        ActiveSupport::Deprecation.warn(<<-DEPRECATION, caller)
          ControllerRequests#viauco_xhr_delete is deprecated and will be removed in Viauco 4.1.
        DEPRECATION
        process_viauco_xhr_action(action, parameters, session, flash, :delete)
      end

      private

      def process_viauco_action(action, parameters = nil, session = nil, flash = nil, method = 'GET')
        parameters ||= {}
        process(action, method: method, params: parameters, session: session, flash: flash)
      end

      def process_viauco_xhr_action(action, parameters = nil, session = nil, flash = nil, method = :get)
        parameters ||= {}
        parameters.reverse_merge!(format: :json)
        process(action, method: method, params: parameters, session: session, flash: flash, xhr: true)
      end
    end
  end
end
