module Viauco
  module Admin
    module CurrencyHelper
      def currency_options(selected_value = nil)
        selected_value ||= Viauco::Config[:currency]
        currencies = ::Money::Currency.table.map do |_code, details|
          iso = details[:iso_code]
          [iso, "#{details[:name]} (#{iso})"]
        end
        options_from_collection_for_select(currencies, :first, :last, selected_value)
      end
    end
  end
end
