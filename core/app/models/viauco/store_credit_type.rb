module Viauco
  class StoreCreditType < Viauco::Base
    DEFAULT_TYPE_NAME = 'Expiring'.freeze
    has_many :store_credits, class_name: 'Viauco::StoreCredit', foreign_key: 'type_id'
  end
end
