class Dog < ActiveRecord::Base
  # ✅ Ensure a many to many relationship between dogs and walks
  has_many :walks
  has_many :feedings

  # Class methods will be defined above instance methods by convention


  # ✅ Refactor: Use AR Query methods to return hungry dogs
  # return all of the dogs who are hungry
  def self.hungry
    self.all.filter do |dog|
      dog.hungry?
    end
  end
  
  # ✅ Refactor: Use AR query methods to return restless dogs
  # return all of the dogs who need a walk
  def self.needs_walking
    self.all.filter do |dog|
      dog.needs_a_walk?
    end
  end
  

  # the age method calculates a dog's age based on their birthdate
  def age
    return nil if self.birthdate.nil?
    days_old = ((Time.now - self.birthdate)/60/60/24).to_i.days
    if days_old < 30.days
      weeks_old = days_old.in_weeks.floor
      "#{weeks_old} #{'week'.pluralize(weeks_old)}"
    elsif days_old < 365.days
      months_old = days_old.in_months.floor
      "#{months_old} #{'month'.pluralize(months_old)}"
    else
      years_old = days_old.in_years.floor
      "#{years_old} #{'year'.pluralize(years_old)}"
    end
  end


  # ✅ Refactor: we're storing duplicate data here, so let's remove the update to last_walked_at
  # we want to be able to take a dog on a walk and track when they were last walked
  def walk
    now = DateTime.now
    self.last_walked_at = now
    self.walks.create(time: now)
  end

  # ✅ Refactor: we're storing duplicate data here, so let's remove the update to last_fed_at 
  # we want to be able to feed a dog and track when they were last fed
  def feed
    now = DateTime.now
    self.last_fed_at = now
    self.feedings.create(time: now)
  end

  # ✅ We'll be removing the last_walked_at and last_fed_at columns, so we'll need to add methods for those.
  
  # ✅ last_walked_at will query the related walks, order them in descending order by time and get the time of the first if it exists

  
  # ✅ last_fed_at will query the related feedings, order them in descending order by time and get the time of the first if it exists


  # We want to know if a dog needs a walk. 
  # Return true if the dog hasn't been walked (that we know of) or their last walk was longer than a set amount of time in the past, otherwise return false.
  def needs_a_walk?
    if last_walked_at
      !last_walked_at.between?(4.hours.ago, DateTime.now)
    else
      true
    end
  end

  # We want to know if a dog is hungry.
  # Return true if the dog hasn't been fed (that we know of) or their last feeding was longer than a set amount of time in the past, otherwise return false
  def hungry?
    if last_fed_at
      !last_fed_at.between?(6.hours.ago, DateTime.now)
    else
      true
    end
  end

  # print details about a dog including the last walked at and last fed at times
  def print
    puts
    puts self.formatted_name
    puts "  Age: #{self.age}"
    puts "  Breed: #{self.breed}"
    puts "  Image Url: #{self.image_url}"
    puts "  Last walked at: #{format_time(self.last_walked_at)}"
    puts "  Last fed at: #{format_time(self.last_fed_at)}"
    puts
  end

  # any methods that we intend for internal use only will be defined below the private keyword
  # helper methods that will only be used by our other instance methods in this class are good candidates for private methods
  private

  # formatted_name
  # The method should return the name in green if the dog has been fed and walked recently
  # The method should return their name in red along with a message in parentheses if they: need a walk, are hungry, or both
  def formatted_name
    if self.hungry? && self.needs_a_walk?
      "#{self.name} (hungry and in need of a walk!)".red
    elsif self.hungry?
      "#{self.name} (hungry)".red
    elsif self.needs_a_walk?
      "#{self.name} (needs a walk)".red
    else
      self.name.green
    end
  end

  def format_time(time)
    time && time.strftime('%Y-%m-%d %H:%M:%S')
  end
  
end