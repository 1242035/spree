module Viauco
  class Role < Viauco::Base
    has_many :role_users, class_name: 'Viauco::RoleUser', dependent: :destroy
    has_many :users, through: :role_users, class_name: Viauco.user_class.to_s

    validates :name, presence: true, uniqueness: { case_sensitive: false, allow_blank: true }
  end
end
