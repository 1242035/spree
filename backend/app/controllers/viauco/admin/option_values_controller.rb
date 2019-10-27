module Viauco
  module Admin
    class OptionValuesController < Viauco::Admin::BaseController
      def destroy
        option_value = Viauco::OptionValue.find(params[:id])
        option_value.destroy
        render plain: nil
      end
    end
  end
end
