ENV["RACK_ENV"] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"])

require_all 'app/models'

# this method can be used from within binding.pry to reload all of your classes so you can use the most recent version of your code without having to exit and re-enter your console/pry session.
# rails has a similar method called `reload!` that you can use within its console, this is a substitute for that method within this environment. 
# The main benefit here is that we can stay in our interactive pry and keep any variables that we've defined while still using the most recent version of our methods defined in our code.
def reload
  # iterate over all files in 'app/models' and load them all (to get new code)
  Dir.glob('app/models/*').each do |file_name|
    load file_name
  end
  puts "all files in app/models/ reloaded"
end