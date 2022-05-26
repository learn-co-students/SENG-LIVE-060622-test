class Walk < ActiveRecord::Base
  # ✅ Refactor associations so walks and dogs are related in a many to many way
  belongs_to :dog

  # ✅ add a .recent method that returns all walks in the last 4 hours

  # takes the time of the walk and formats it as a string like this:
  # Friday, 04/08 4:57 PM
  def formatted_time
    time.strftime('%A, %m/%d %l:%M %p')
  end

  # this will display the day and time of the walk
  # and all of the dogs that were on it below
  def print
    puts ""
    puts self.formatted_time.light_green
    puts "Dogs: "
    self.dogs.each do |dog|
      puts "  #{dog.name}"
    end
    puts ""
  end
end