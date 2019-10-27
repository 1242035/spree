module Viauco
  module UserApiMethods
    extend ActiveSupport::Concern

    include Viauco::UserApiAuthentication
  end
end
