DOGS = []

def start_cli
  puts "hello! Welcome to the Dog Walker CLI"
  print_menu_options
  choice = ask_for_choice
  until choice == "exit"
    handle_choice(choice)
    choice = ask_for_choice
  end
  puts "Thank you for using the Dog Walker CLI!"
end

def print_menu_options
  puts "Here's a list of the options. Type:".cyan
  puts "  1. To add a dog".cyan
  puts "  2. To list dogs".cyan
  puts "  menu to show the options again, or".cyan
  puts "  exit to leave the program".cyan
end

def ask_for_choice
  print "What would you like to do? "
  gets.chomp
end

def handle_user_choice
  input = gets.chomp
  while input != "exit"
    if input == "1"
      add_dog
    elsif input == "2"
      list_dogs
    elsif input == "debug" 
      binding.pry
    else 
      puts "Whoops! I didn't understand your choice".red
    end
    main_menu
    input = gets.chomp
  end
end

def add_dog
  puts "Sure! Let's add your dog!"
  dog_hash = {}
  print "What's your dog's name? "
  dog_hash[:name] = gets.chomp
  print "What's your dog's age? "
  dog_hash[:age] = gets.chomp
  print "What's your dog's breed? "
  dog_hash[:breed] = gets.chomp
  print "What are your dog's favorite treats? "
  dog_hash[:favorite_treats] = gets.chomp
  DOGS.push(dog_hash)
  print_dog(dog_hash)
end

def list_dogs
  puts "here are the dogs"
  DOGS.each do |dog_hash|
    print_dog(dog_hash)
  end
end

def print_dog(dog_hash)
  puts ""
  puts dog_hash[:name].light_green
  puts "  age: #{dog_hash[:age]}"
  puts "  breed: #{dog_hash[:breed]}"
  puts "  favorite_treats: #{dog_hash[:favorite_treats]}"
  puts ""
end