module Viauco
  class PromotionCategory < Viauco::Base
    validates :name, presence: true
    has_many :promotions
  end
end
