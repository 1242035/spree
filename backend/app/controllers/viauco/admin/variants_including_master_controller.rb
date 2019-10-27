module Viauco
  module Admin
    class VariantsIncludingMasterController < VariantsController
      belongs_to 'viauco/product', find_by: :slug

      def model_class
        Viauco::Variant
      end

      def object_name
        'variant'
      end
    end
  end
end
