# Default implementation of User.  This class is intended to be modified by extensions (ex. viauco_auth_devise)
module Viauco
  class LegacyUser < Viauco::Base
    include UserAddress
    include UserPaymentSource
    include UserMethods

    self.table_name = 'viauco_users'

    attr_accessor :password
    attr_accessor :password_confirmation
  end
end
