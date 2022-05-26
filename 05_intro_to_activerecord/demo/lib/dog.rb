# ✅ We're going to inherit from ActiveRecord::Base here so we can get methods for DB persistence
class Dog
  # ✅ Association macros are generally added near the top of class definitions
  # Class methods will be defined above initialize by convention
  # and instance methods will be defined below initialize

  # ✅ Because we'll be inheriting from ActiveRecord::Base now, some of these methods will be defined in the Base class for us, so we can remove them from the Dog class:
  # We can remove the following:
  
  # --- @@all
  # --- def self.all
  # --- def self.new_from_row
  # --- def self.create
  # --- all attr_accessors & attr_reader
  # --- def initialize 
  # --- def save

  # We'll want to leave our custom methods that work with instances within the CLI, but all of the code related to persistence can be removed as we'll be using the versions of those methods defined in the ActiveRecord::Base class instead.


  # Begin ❌❌❌❌❌
  # We'll use the @@all class variable to cache dogs we've retrieved from the database
  # in order to create our caching logic, we'll initialize @@all to nil, that way we can use the ||= operator within self.all to assign it an initial value. 

  @@all = nil

  # We want to be able to access the current state of the stored dogs

  def self.all
    # We still want to use the @@all class variable so we only have
    # to query the database for all records the first time we invoke
    # this method. 
    # The first call to `.all` should trigger the query and use the
    # results to create and return a collection of dogs which we'll
    # assign to @@all
    # The next call to the method should return the previously 
    # assigned value of @@all
    @@all ||= DB.execute("SELECT * FROM dogs").map do |row|
      self.new_from_row(row)
    end
  end

  def self.new_from_row(row)
    self.new(row.transform_keys(&:to_sym))
  end
  # End ❌❌❌❌❌

  # return all of the dogs who are hungry
  def self.hungry
    self.all.filter do |dog|
      dog.hungry?
    end
  end
  
  # return all of the dogs who need a walk
  def self.needs_walking
    self.all.filter do |dog|
      dog.needs_a_walk?
    end
  end
  
  # Begin ❌❌❌❌❌

  # create should accept the same arguments as .new, invoke new and then save the created instance to @@all
  def self.create(attributes)
    self.new(attributes).save
  end

  
  attr_accessor :name, :birthdate, :breed, :image_url, :last_walked_at, :last_fed_at
  
  # we want to have readonly access to the id assigned by the database. This shouldn't be changed by our ruby code, only retrieved.
  attr_reader :id

  # We want to be able to create new dog instances for testing purposes without necessarily saving them within the collection of stored instances - so we won't be saving all new instances into our stored collection
  # But, we will want to be able to create new instances from rows stored in our database as well, and for that we may have additional information to add upon initialization. 
  # - The database row will be assigned an id, which will be an important property for the instance to have. 
  # - The row may also have values for last_walked_at or last_fed_at
  def initialize(id: nil, name:, birthdate:, breed:, image_url:, last_walked_at: nil, last_fed_at: nil)
    @id = id
    @name = name
    @birthdate = DateTime.parse(birthdate)
    @breed = breed
    @image_url = image_url
    @last_walked_at = last_walked_at && DateTime.parse(last_walked_at).change(:offset => "-0700")
    @last_fed_at = last_fed_at && DateTime.parse(last_fed_at).change(:offset => "-0700")
  end

  # The save method will insert a new row in the database for dogs that don't have an id and update the existing row in the database if the dog does have an id.
  def save
    # if the dog has an id, then it's already been saved
    # so we want to trigger an UPDATE to the existing dog
    if id 
      # use a HEREDOC to compose a multi line query
      # https://ruby-doc.org/core-2.7.4/doc/syntax/literals_rdoc.html#label-Here+Documents+-28heredocs-29
      query = <<-SQL
        UPDATE dogs
        SET name = ?,
            birthdate = ?,
            breed = ?,
            image_url = ?,
            last_walked_at = ?,
            last_fed_at = ?
        WHERE
            id = ? 
      SQL
      # add ? marks to any pieces of the query that may come from user input
      # these are called bind params and they're used to escape (or sanitize)
      # anything in this string that has syntactical meaning in SQL like:
      # (), "", ;, etc. The characters will appear in the QUERY string 
      # rather than being interpreted as SQL syntax.
      # https://github.com/sparklemotion/sqlite3-ruby/blob/master/faq/faq.md#how-do-i-use-placeholders-in-an-sql-statement
      # The database requires times to be formatted in a particular way,
      # so we're using the strftime method (string format time) to convert
      # the ruby time objects for last_walked_at and last_fed_at into a string 
      # format that sqlite3 expects
      DB.execute(
        query,
        self.name,
        format_time(self.birthdate),
        self.breed,
        self.image_url,
        self.last_walked_at && format_time(self.last_walked_at),
        self.last_fed_at && format_time(self.last_fed_at),
        self.id
      )
    else
      # if the dog hasn't been saved yet, we'll trigger an INSERT
      query = <<-SQL
        INSERT INTO dogs 
        (name, birthdate, breed, image_url, last_walked_at, last_fed_at)
        VALUES
        (?, ?, ?, ?, ?, ?)
      SQL
      DB.execute(
        query,
        self.name,
        format_time(self.birthdate),
        self.breed,
        self.image_url,
        self.last_walked_at && format_time(self.last_walked_at),
        self.last_fed_at && format_time(self.last_fed_at)
      )
      # Since the dog's id will be assigned by the database
      # we'll need to tell the dog object about the last assigned id
      # we can retrieve that id from the database using the following query
      @id = DB.execute("SELECT last_insert_rowid()")[0]["last_insert_rowid()"]
      # Since the dog has been added to the database just now we should add it
      # to @@all if we've already queried to retrieve all of the dogs
      @@all && @@all << self
    end
    self
  end

  # End ❌❌❌❌❌

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


  # we want to be able to take a dog on a walk and track when they were last walked
  def walk
    @last_walked_at = DateTime.now
  end

  # we want to be able to feed a dog and track when they were last fed
  def feed
    @last_fed_at = DateTime.now
  end

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