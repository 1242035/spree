module Viauco
  module UserApiAuthentication
    def generate_viauco_api_key!
      self.viauco_api_key = generate_viauco_api_key
      save!
    end

    def clear_viauco_api_key!
      self.viauco_api_key = nil
      save!
    end

    private

    def generate_viauco_api_key
      SecureRandom.hex(24)
    end
  end
end
