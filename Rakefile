require 'rake'
require 'rubygems/package_task'
require 'thor/group'
begin
  require 'viauco/testing_support/common_rake'
rescue LoadError
  raise "Could not find viauco/testing_support/common_rake. You need to run this command using Bundler."
end

VIAUCO_GEMS = %w(core api cmd backend frontend sample).freeze

task default: :test

desc "Runs all tests in all Viauco engines"
task test: :test_app do
  VIAUCO_GEMS.each do |gem_name|
    Dir.chdir("#{File.dirname(__FILE__)}/#{gem_name}") do
      sh 'rspec'
    end
  end
end

desc "Generates a dummy app for testing for every Viauco engine"
task :test_app do
  VIAUCO_GEMS.each do |gem_name|
    Dir.chdir("#{File.dirname(__FILE__)}/#{gem_name}") do
      sh 'rake test_app'
    end
  end
end

desc "clean the whole repository by removing all the generated files"
task :clean do
  rm_f  "Gemfile.lock"
  rm_rf "sandbox"
  rm_rf "pkg"

  VIAUCO_GEMS.each do |gem_name|
    rm_f  "#{gem_name}/Gemfile.lock"
    rm_rf "#{gem_name}/pkg"
    rm_rf "#{gem_name}/spec/dummy"
  end
end

namespace :gem do
  def version
    require 'viauco/core/version'
    Viauco.version
  end

  def for_each_gem
    VIAUCO_GEMS.each do |gem_name|
      yield "pkg/viauco_#{gem_name}-#{version}.gem"
    end
    yield "pkg/viauco-#{version}.gem"
  end

  desc "Build all viauco gems"
  task :build do
    pkgdir = File.expand_path("../pkg", __FILE__)
    FileUtils.mkdir_p pkgdir

    VIAUCO_GEMS.each do |gem_name|
      Dir.chdir(gem_name) do
        sh "gem build viauco_#{gem_name}.gemspec"
        mv "viauco_#{gem_name}-#{version}.gem", pkgdir
      end
    end

    sh "gem build viauco.gemspec"
    mv "viauco-#{version}.gem", pkgdir
  end

  desc "Install all viauco gems"
  task install: :build do
    for_each_gem do |gem_path|
      Bundler.with_clean_env do
        sh "gem install #{gem_path}"
      end
    end
  end

  desc "Release all gems to rubygems"
  task release: :build do
    sh "git tag -a -m \"Version #{version}\" v#{version}"

    for_each_gem do |gem_path|
      sh "gem push '#{gem_path}'"
    end
  end
end

desc "Creates a sandbox application for simulating the Viauco code in a deployed Rails app"
task :sandbox do
  Bundler.with_clean_env do
    exec("lib/sandbox.sh")
  end
end
