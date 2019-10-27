module Viauco
  class PropertyPrototype < Viauco::Base
    belongs_to :prototype, class_name: 'Viauco::Prototype'
    belongs_to :property, class_name: 'Viauco::Property'

    validates :prototype, :property, presence: true
    validates :prototype_id, uniqueness: { scope: :property_id }
  end
end
