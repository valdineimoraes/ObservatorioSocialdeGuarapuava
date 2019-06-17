require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

<<<<<<< HEAD
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

=======
>>>>>>> edba02ce57ff23f59a93524bc26458e75fc16747
require 'rspec/rails'

require 'support/bullet'
require 'support/shoulda'
require 'support/database_cleaner'
<<<<<<< HEAD
=======
require 'support/simplecov'
require 'support/helpers/form'
require 'support/bullet'
>>>>>>> edba02ce57ff23f59a93524bc26458e75fc16747
require 'support/file_spec_helper'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end