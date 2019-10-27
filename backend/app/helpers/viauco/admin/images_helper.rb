module Viauco
  module Admin
    module ImagesHelper
      def options_text_for(image)
        if image.viewable.is_a?(Viauco::Variant)
          if image.viewable.is_master?
            Viauco.t(:all)
          else
            image.viewable.sku_and_options_text
          end
        else
          Viauco.t(:all)
        end
      end
    end
  end
end
