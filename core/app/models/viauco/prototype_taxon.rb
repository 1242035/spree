module Viauco
  class PrototypeTaxon < Viauco::Base
    belongs_to :taxon, class_name: 'Viauco::Taxon'
    belongs_to :prototype, class_name: 'Viauco::Prototype'

    validates :prototype, :taxon, presence: true
    validates :prototype_id, uniqueness: { scope: :taxon_id }
  end
end
