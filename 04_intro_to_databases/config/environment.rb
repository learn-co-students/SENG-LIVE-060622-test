# require is like an import statement except it loads all methods from the required file (not just the default export)

# require pry so we can use binding.pry within our code
require "pry"
# require "require_all" so we're able to load all files in the
# lib directory all at once
require "require_all"

# add the ability to print colored strings
require "colorize"

# add the ability to do calculations with dates
require "date"
require "active_support/core_ext/integer/time"
require "active_support/core_ext/date/calculations"

# Add require statement for sqlite3 so we can use the SQLite3::Database class
require "sqlite3"

# DB is a constant that will be accessible throughout our applications
# it stores an instance of the SQLite3::Database class which will allow us to execute SQL queries on our database and get the results in a ruby array.
DB = SQLite3::Database.new("db/dog_walker.db")

# if we set the results_as_hash property to true, then we'll receive the results as an array of hashes rather than an array of arrays.
# each hash will represent a row in the table and the column values will correspond to the column names as keys in the hash:
# [{name: "Lennon Snow", age: "2 years", breed: "Pomeranian", image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1609370267/dakota-and-lennon-square-compressed_hoenfo.jpg"}]
DB.results_as_hash = true


# When we use `require_all`, the path we pass to it will be 
# relative to the root path of the project (where the Gemfile 
# is). In our case, we're loading all of the files inside of 
# the lib directory, so if we write code in there (like a 
# method) it will be accessible to us after the require_all
# below
require_all "lib"