require 'cancan'
require_dependency 'viauco/core/controller_helpers/strong_parameters'

class Viauco::BaseController < ApplicationController
  include Viauco::Core::ControllerHelpers::Auth
  include Viauco::Core::ControllerHelpers::Common
  include Viauco::Core::ControllerHelpers::Search
  include Viauco::Core::ControllerHelpers::Store
  include Viauco::Core::ControllerHelpers::StrongParameters

  respond_to :html
end

require 'viauco/i18n/initializer'
