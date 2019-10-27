module Viauco
  class ReturnAuthorizationReason < Viauco::Base
    include Viauco::NamedType

    has_many :return_authorizations, dependent: :restrict_with_error
  end
end
