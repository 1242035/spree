if ENV['COVERAGE']
  # Run Coverage report
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_group 'Serializers', 'app/serializers'
    add_group 'Libraries', 'lib/viauco'

    add_filter '/bin/'
    add_filter '/db/'
    add_filter '/script/'
    add_filter '/spec/'
    add_filter '/lib/viauco/api/testing_support/'

    coverage_dir "#{ENV['COVERAGE_DIR']}/api" if ENV['COVERAGE_DIR']
  end
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

begin
  require File.expand_path('../dummy/config/environment', __FILE__)
rescue LoadError
  puts 'Could not load dummy application. Please ensure you have run `bundle exec rake test_app`'
  exit
end

require 'rspec/rails'
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

require 'viauco/testing_support/factories'
require 'viauco/testing_support/preferences'
require 'viauco/testing_support/image_helpers'

require 'viauco/api/testing_support/caching'
require 'viauco/api/testing_support/helpers'
require 'viauco/api/testing_support/setup'
require 'viauco/api/testing_support/v2/base'
require 'viauco/api/testing_support/v2/current_order'

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = [/gems\/activesupport/, /gems\/actionpack/, /gems\/rspec/]
  config.color = true
  config.default_formatter = 'doc'
  config.fail_fast = ENV['FAIL_FAST'] || false
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.use_transactional_fixtures = true

  config.include JSONAPI::RSpec
  config.include FactoryBot::Syntax::Methods
  config.include Viauco::Api::TestingSupport::Helpers, type: :controller
  config.include Viauco::Api::TestingSupport::Helpers, type: :request
  config.extend Viauco::Api::TestingSupport::Setup, type: :controller
  config.include Viauco::TestingSupport::Preferences, type: :controller
  config.include Viauco::TestingSupport::ImageHelpers

  config.before do
    Viauco::Api::Config[:requires_authentication] = true
  end

  config.order = :random
  Kernel.srand config.seed
end
