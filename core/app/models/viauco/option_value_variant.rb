module Viauco
  class OptionValueVariant < Viauco::Base
    belongs_to :option_value, class_name: 'Viauco::OptionValue'
    belongs_to :variant, class_name: 'Viauco::Variant'

    validates :option_value, :variant, presence: true
    validates :option_value_id, uniqueness: { scope: :variant_id }
  end
end
