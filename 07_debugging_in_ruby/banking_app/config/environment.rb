ENV["RACK_ENV"] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"])

require_all 'app/models'


def reload
  # iterate over all files in 'app/models' and load them all (to get new code)
  Dir.glob('app/models/*').each do |file_name|
    load file_name
  end
  puts "all files in app/models/ reloaded"
end
