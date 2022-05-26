def start_cli
  puts "Hi there! Welcome to the Dog Walker CLI!".cyan
end

# prints the menu options that users can choose from
def print_menu_options
  puts "Here are the choices:"
  puts "  1. List all dogs"
  puts "  2. Add a dog"
  puts "  3. To walk a dog"
  puts "  4. To feed a dog"
  puts "Please choose the number matching your choice."
  puts 'At any time, type "exit" to leave the program'
end

# `ask_for_choice` prompts the user for input
# if the user types "exit" we'll print a message thanking them
# for using the CLI and invoke exit to terminate the program
# otherwise, return whatever the user typed in
def ask_for_choice
  input = gets.chomp
  if input == "exit"
    puts "Thanks for using the Dog Walker CLI!".green
    exit
  end
  input
end




# `list_dogs` will iterate over an array of
# dog instances and call print on each one.
def list_dogs(dogs)
  dogs.each do |dog|
    dog.print
  end
end


# ✅ Refactor
# The `add_dog` method doesn't need to accept an array of dog
# instances as an argument anymore.
# The dog class is now taking ownership of storing dogs, 
# so we'll use the appropriate method to make sure the dog we create is saved

# add_dog should:
# ask the user for input of the
# dog's name, age, breed and image_url. 
# Take this information and use it to create a new instance
# of the dog class (using the method that causes the dog class to save it)
# print the newly saved dog (by invoking dog.print)
def add_dog(dogs)
  print "What's the dog's name? "
  name = ask_for_choice
  print "What's the dog's age? "
  age = ask_for_choice
  print "What's the dog's breed? "
  breed = ask_for_choice
  print "What's the dog's image url? "
  image_url = ask_for_choice

  # ✅ Rework the code below to use the Dog class's create method

  dog = Dog.new(name, age, breed, image_url)
  dogs << dog
  dog.print
end


# ✅ Refactor: 
# 1. We're going to remove all references to $dogs within this method because the Dog class is now taking ownership of managing collections of dogs
# 2. within the logic for handling choice 3 for walking a dog, we'll pass in only the dogs that need a walk (instead of all the dogs)
# 3. within the logic for handling choice 4 for feeding a dog, we'll pass in only the dogs that are hungry (instead of all the dogs)

# handle the choice that a user makes by calling the appropriate method or printing an error message if the user types something other than one of our specified options
def handle_choice(choice)
  if choice == "1"
    list_dogs($dogs)
  elsif choice == "2"
    add_dog($dogs)
  elsif choice == "3"
    walk_dog($dogs)
  elsif choice == "4"
    feed_dog($dogs)
  elsif choice == "debug"
    binding.pry
  else
    puts "Whoops! I didn't understand that!".red
    puts "Please try again."
  end
end

# ✅ Refactor

# `choose_dog_from_collection` will:
#  - accept an array of dog instances as an argument
#  - print a numbered list (starting from 1) of each dog's name (breed) 
#    using .each_with_index
# https://ruby-doc.org/core-2.7.4/Enumerable.html#method-i-each_with_index
#  - ask the user to choose a number matching the dog they want to interact with
#  - return the dog instance corresponding to the choice they made
#  - ask the user to choose again if their choice didn't match a dog

def choose_dog_from_collection(dogs)
  dogs.each_with_index do |dog, index|
    puts "#{index+1}. #{dog.name} (#{dog.breed})"
  end
  puts "Type the number associated with the dog you'd like to choose"
  # this code converts the number typed by the user and stored as a string
  # to an integer and then subtracts 1 to get the corresponding index in
  # the dogs array
  index = ask_for_choice.to_i - 1
  # next we check if we got a valid choice and if not, we'll show an error 
  # and ask the user to choose again by invoking the method again.
  # we add index >= 0 to our condition because .to_i will return 0 if passed
  # a word that doesn't start with a number as an argument.
  # in that case, we'll end up with -1 and we'd prefer telling the user there
  # was a problem to doing dogs[-1] which actually returns the last dog in the array
  if index >= 0 && index < dogs.length
    dogs[index]
  else
    puts "Whoops! We couldn't find a dog matching your choice.".red
    puts "Please try again"
    choose_dog_from_collection(dogs)
  end
end

# `walk_dog` will prompt the user to choose which dog to walk. 
# After choosing a dog, invoke the `walk` method
# on the dog and then `print` it

def walk_dog(dogs)
  dog = choose_dog_from_collection(dogs)
  dog.walk
  dog.print
end



# `feed_dog` will prompt the user to choose which dog to feed. 
# After choosing a dog, invoke the `feed` method
# on the dog and then `print` it
def feed_dog(dogs)
  dog = choose_dog_from_collection(dogs)
  dog.feed
  dog.print
end