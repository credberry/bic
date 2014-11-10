require 'simplecov'
SimpleCov.start do
  add_filter 'spec' # ignore spec files
end

if ENV['CC']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require File.expand_path('../../lib/bic', __FILE__)

include Bic::Validation

