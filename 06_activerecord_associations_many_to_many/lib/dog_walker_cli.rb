PROMPT = TTY::Prompt.new(interrupt: :exit)
def start_cli
  puts "Hi there! Welcome to the Dog Walker CLI!".cyan
end

def main_menu
  puts "What would you like to do? Type the number that matches your choice or 'exit' to leave the program".cyan
  puts "Here's a list of the options. Type:".cyan
  puts "  1. To add a dog".cyan
  puts "  2. To view Dog Info".cyan
  puts "  3. To add a walk".cyan
  puts "  4. To view Walk info".cyan
  puts "  exit to leave the program".cyan
end

def handle_choice(choice)
  if choice == "1"
    add_dog
  elsif choice == "2"
    dog_info
  elsif choice == "3"
    create_walk
  elsif choice == "4"
    walk_info
  elsif choice == "debug" 
    binding.pry
  else 
    puts "Whoops! I didn't understand your choice".red
  end
end

# add_dog should:
# ask the user for input of the
# dog's name, birthday, breed and image_url. 
# Take this information and use it to create a new instance
# of the dog class (using the method that causes the dog class to save it)
# print the newly saved dog (by invoking dog.print)
def add_dog
  print "What's the dog's name? "
  name = ask_for_choice
  print "What's the dog's birthday? (YYYY-MM-DD) "
  birthdate = ask_for_choice
  print "What's the dog's breed? "
  breed = ask_for_choice
  print "What's the dog's image url? "
  image_url = ask_for_choice


  dog = Dog.create(
    name: name, 
    birthdate: birthdate,
    breed: breed,
    image_url: image_url
  )
  dog.print
end

def dog_info
  list_dogs
  print_dog_interaction_choices
  input = ask_for_choice
  until input == "back"
    if input == "1" 
      feed_dog
    elsif input == "2"
      walk_dog
    elsif input == "3"
      list_dogs_who_need_feeding
    elsif input == "4"
      list_dogs_who_need_walking
    elsif input == "5"
      list_walks_for_dog
    elsif input == "6"
      list_feedings_for_dog
    else
      puts "Whoops! I didn't understand your choice".red
    end
    print_dog_interaction_choices
    input = ask_for_choice
  end
end

def list_dogs
  puts "Dogs: "
  Dog.all.each do |dog|
    puts dog.name
  end
end

def print_dog_interaction_choices
  puts "Dogs Submenu: What would you like to do?"
  puts "  1. To feed a dog".cyan
  puts "  2. To walk a dog".cyan
  puts "  3. To view all dogs who need feeding".cyan
  puts "  4. To view all dogs who need walking".cyan
  puts "  5. To view all walks for a particular dog".cyan
  puts "  6. To view all feedings for a particular dog".cyan
  puts "  back to return to the main menu".cyan
  puts "  exit to leave the program".cyan
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

def feed_dog
  puts "pick the number matching the dog you'd like to feed" 
  dog = prompt_user_to_choose_dog
  return if dog == "back"
  dog.feed
  dog.print
end

def walk_dog
  puts "pick the number matching the dog you'd like to walk" 
  dog = prompt_user_to_choose_dog
  return if dog == "back"
  dog.walk
  dog.print
end

def list_dogs_who_need_feeding
  puts "Dogs who need feeding:".light_green
  dogs = Dog.hungry
  dogs.each do |dog|
    dog.print
  end
  if dogs.empty?
    puts "All dogs are fed!"
  end
end

def list_dogs_who_need_walking
  puts "Dogs who need walking:".light_green
  dogs = Dog.needs_walking
  dogs.each do |dog|
    dog.print
  end
  if dogs.empty?
    puts "All dogs are walked!"
  end
end

def list_walks_for_dog
  puts "Which dog do you want to view past walks for?"
  dog = prompt_user_to_choose_dog
  return if dog == "back"
  puts "Recent walks for #{dog.name}:"
  dog.walks.order(time: :desc).each do |walk|
    puts "time: #{walk.formatted_time}"
  end
end

def list_feedings_for_dog
  puts "Which dog do you want to view past feedings for?"
  dog = prompt_user_to_choose_dog
  return if dog == "back"
  puts "Recent feedings for #{dog.name}:"
  dog.feedings.order(time: :desc).each do |feeding|
    puts "time: #{feeding.formatted_time}"
  end
end

def create_walk
  options = Dog.all.reduce({}) do |memo, dog|
    memo[dog.name] = dog.id
    memo
  end
  dog_ids = PROMPT.multi_select("Which dogs would you like to take on the walk?", options)
  walk = Walk.create(time: Time.now, dog_ids: dog_ids)
  walk.print
end

def walk_info
  walk = PROMPT.select("Which walk would you like to choose?") do |menu|
    Walk.order(time: :desc).each do |walk|
      menu.choice walk.formatted_time, walk
    end
    menu.choice "back"
  end
  return if walk == "back"
  walk.print
end

def prompt_user_to_choose_dog
  PROMPT.select("Which dog would you like to choose?") do |menu|
    Dog.all.each do |dog|
      menu.choice dog.name, dog
    end
    menu.choice "back"
  end
end
