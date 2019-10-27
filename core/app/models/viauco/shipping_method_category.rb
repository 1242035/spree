module Viauco
  class ShippingMethodCategory < Viauco::Base
    belongs_to :shipping_method, class_name: 'Viauco::ShippingMethod'
    belongs_to :shipping_category, class_name: 'Viauco::ShippingCategory', inverse_of: :shipping_method_categories
  end
end
