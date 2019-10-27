module Viauco
  module CalculatedAdjustments
    extend ActiveSupport::Concern

    included do
      has_one :calculator, class_name: 'Viauco::Calculator', as: :calculable, inverse_of: :calculable, dependent: :destroy, autosave: true
      accepts_nested_attributes_for :calculator
      validates :calculator, presence: true
      delegate :compute, to: :calculator

      def self.calculators
        viauco_calculators.send model_name_without_viauco_namespace
      end

      def calculator_type
        calculator.class.to_s if calculator
      end

      def calculator_type=(calculator_type)
        klass = calculator_type.constantize if calculator_type
        self.calculator = klass.new if klass && !calculator.is_a?(klass)
      end

      private

      def self.model_name_without_viauco_namespace
        to_s.tableize.tr('/', '_').sub('viauco_', '')
      end

      def self.viauco_calculators
        Rails.application.config.viauco.calculators
      end
    end
  end
end
