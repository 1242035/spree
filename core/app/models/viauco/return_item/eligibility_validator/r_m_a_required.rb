module Viauco
  class ReturnItem::EligibilityValidator::RMARequired < Viauco::ReturnItem::EligibilityValidator::BaseValidator
    def eligible_for_return?
      if @return_item.return_authorization.present?
        true
      else
        add_error(:rma_required, Viauco.t('return_item_rma_ineligible'))
        false
      end
    end

    def requires_manual_intervention?
      false
    end
  end
end
