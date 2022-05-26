ENV["AR_ENVIRONMENT"] ||= "development"
# require is like an import statement except it loads all methods from the required file (not just the default export)
require "bundler/setup"
# Here we're calling a method that requires all of the ruby gems in the default environment (not in a group like development or test) For our purposes, this will load require_all and pry so that we can use `require_all` and `binding.pry` within our code
Bundler.require(:default, ENV["AR_ENVIRONMENT"])

require "date"
require "active_support/core_ext/integer/time"
require "active_support/core_ext/date/calculations"
# One of our dependencies that we loaded in the previous expression was the require_all gem. It allows us to require all of the files within a directory. The path we pass to it will be relative to the root path of the project (where the Gemfile is). In our case, we're loading all of the files inside of the lib directory, so if we write code in there (like a method) it will be accessible to us after the require_all below

DB = SQLite3::Database.new("db/dog_walker.db")
DB.results_as_hash = true

# our application won't support different timezones 
# we'll default to displaying all times in local time
# this will get around the problem with the offset for now
ActiveRecord::Base.default_timezone = :local
require_all "lib"