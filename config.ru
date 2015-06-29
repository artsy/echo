require File.expand_path('../config/application.rb', __FILE__)

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Echo::Application.instance
