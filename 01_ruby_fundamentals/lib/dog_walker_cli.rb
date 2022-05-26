def start_cli
  puts "Hi there! Welcome to the Dog Walker CLI!".cyan
end

# define a method `print_menu_options` which outlines the user's
# choices. The choices will be displayed as a numbered list like so:
#   1. List all dogs
#   2. Add a dog
# At any time, type "menu" to see these options again or "exit" to
# leave the program




# define a method `ask_for_choice` which prompts the user for input
# if the user types "exit" we'll print a message thanking them
# for using the CLI and invoke exit to terminate the program
# otherwise, return whatever the user typed in



# define a `print_dog` method that accepts a dog hash as a parameter
# and prints out the dog's details that looks like this:
=begin
  
Lennon Snow
  Age: Almost 2
  Breed: Pomeranian
  Image URL: https://res.cloudinary.com/dnocv6uwb/image/upload/v1609370267/dakota-and-lennon-square-compressed_hoenfo.jpg

=end




# define a method `list_dogs` that will iterate over an array of
# dog hashes and call print_dog on each one.



# define an `add_dog` method which accepts an array of dog
# hashes as an argument. It should:
# ask the user for input of the
# dog's name, age, breed and image_url. 
# Take this information and put it into a hash
# add the hash to the dogs array passed as an argument
# print the newly added dog



# define a method `handle_choice` which will take a `choice` as a 
# parameter and handle it in the appropriate way based on the menu
# option that was chosen




