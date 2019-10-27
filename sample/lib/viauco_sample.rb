require 'viauco_core'
require 'viauco/sample'

module ViaucoSample
  class Engine < Rails::Engine
    engine_name 'viauco_sample'

    # Needs to be here so we can access it inside the tests
    def self.load_samples
      Viauco::Sample.load_sample('payment_methods')
      Viauco::Sample.load_sample('shipping_categories')
      Viauco::Sample.load_sample('shipping_methods')
      Viauco::Sample.load_sample('tax_categories')
      Viauco::Sample.load_sample('tax_rates')

      Viauco::Sample.load_sample('products')
      Viauco::Sample.load_sample('taxons')
      Viauco::Sample.load_sample('option_values')
      Viauco::Sample.load_sample('product_option_types')
      Viauco::Sample.load_sample('product_properties')
      Viauco::Sample.load_sample('prototypes')
      Viauco::Sample.load_sample('variants')
      Viauco::Sample.load_sample('stock')
      Viauco::Sample.load_sample('assets')

      Viauco::Sample.load_sample('orders')
      Viauco::Sample.load_sample('adjustments')
      Viauco::Sample.load_sample('payments')
      Viauco::Sample.load_sample('store_credit_categories')
    end
  end
end
