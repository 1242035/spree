require 'i18n'
require 'active_support/core_ext/array/extract_options'
require 'viauco/i18n/base'

module Viauco
  extend ActionView::Helpers::TranslationHelper
  extend ActionView::Helpers::TagHelper

  class << self
    # Add viauco namespace and delegate to Rails TranslationHelper for some nice
    # extra functionality. e.g return reasonable strings for missing translations
    def translate(*args)
      @virtual_path = virtual_path

      options = args.extract_options!
      options[:scope] = [*options[:scope]].unshift(:viauco)
      args << options
      super(*args)
    end

    alias t translate

    def context
      Viauco::ViewContext.context
    end

    def virtual_path
      if context
        path = context.instance_variable_get('@virtual_path')

        path&.gsub(/viauco/, '')
      end
    end
  end
end
