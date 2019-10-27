module Viauco
  class ShippingMethodZone < Viauco::Base
    belongs_to :shipping_method
    belongs_to :zone
  end
end
