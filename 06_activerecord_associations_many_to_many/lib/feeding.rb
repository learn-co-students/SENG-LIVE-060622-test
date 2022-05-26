class Feeding < ActiveRecord::Base
  belongs_to :dog

  # takes the time of the feeding and formats it as a string like this:
  # Friday, 04/08 4:57 PM
  def formatted_time
    time.strftime('%A, %m/%d %l:%M %p')
  end
end