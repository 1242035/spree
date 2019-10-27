module Viauco
  module ViewContext
    def self.context=(context)
      @context = context
    end

    def self.context
      @context
    end

    def view_context
      super.tap do |context|
        Viauco::ViewContext.context = context
      end
    end
  end
end
