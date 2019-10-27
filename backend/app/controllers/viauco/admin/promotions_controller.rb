module Viauco
  module Admin
    class PromotionsController < ResourceController
      before_action :load_data, except: :clone

      helper 'viauco/admin/promotion_rules'

      def clone
        promotion = Viauco::Promotion.find(params[:id])
        duplicator = Viauco::PromotionHandler::PromotionDuplicator.new(promotion)

        @new_promo = duplicator.duplicate

        if @new_promo.errors.empty?
          flash[:success] = Viauco.t('promotion_cloned')
          redirect_to edit_admin_promotion_url(@new_promo)
        else
          flash[:error] = Viauco.t('promotion_not_cloned', error: @new_promo.errors.full_messages.to_sentence)
          redirect_to admin_promotions_url(@new_promo)
        end
      end

      protected

      def location_after_save
        viauco.edit_admin_promotion_url(@promotion)
      end

      def load_data
        @calculators = Rails.application.config.viauco.calculators.promotion_actions_create_adjustments
        @promotion_categories = Viauco::PromotionCategory.order(:name)
      end

      def collection
        return @collection if defined?(@collection)

        params[:q] ||= HashWithIndifferentAccess.new
        params[:q][:s] ||= 'id desc'

        @collection = super
        @search = @collection.ransack(params[:q])
        @collection = @search.result(distinct: true).
                      includes(promotion_includes).
                      page(params[:page]).
                      per(params[:per_page] || Viauco::Config[:admin_promotions_per_page])
      end

      def promotion_includes
        [:promotion_actions]
      end
    end
  end
end
