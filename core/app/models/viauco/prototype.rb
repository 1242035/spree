module Viauco
  class Prototype < Viauco::Base
    has_many :property_prototypes, class_name: 'Viauco::PropertyPrototype'
    has_many :properties, through: :property_prototypes, class_name: 'Viauco::Property'

    has_many :option_type_prototypes, class_name: 'Viauco::OptionTypePrototype'
    has_many :option_types, through: :option_type_prototypes, class_name: 'Viauco::OptionType'

    has_many :prototype_taxons, class_name: 'Viauco::PrototypeTaxon'
    has_many :taxons, through: :prototype_taxons, class_name: 'Viauco::Taxon'

    validates :name, presence: true
  end
end
