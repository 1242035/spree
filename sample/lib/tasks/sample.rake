require 'ffaker'
require 'pathname'
require 'viauco/sample'

namespace :viauco_sample do
  desc 'Loads sample data'
  task load: :environment do
    if ARGV.include?('db:migrate')
      puts %Q{
Please run db:migrate separately from viauco_sample:load.

Running db:migrate and viauco_sample:load at the same time has been known to
cause problems where columns may be not available during sample data loading.

Migrations have been run. Please run 'rake viauco_sample:load' by itself now.
      }
      exit(1)
    end

    ViaucoSample::Engine.load_samples
  end
end
