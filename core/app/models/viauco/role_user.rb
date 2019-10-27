module Viauco
  class RoleUser < Viauco::Base
    belongs_to :role, class_name: 'Viauco::Role'
    belongs_to :user, class_name: Viauco.user_class.to_s
  end
end
