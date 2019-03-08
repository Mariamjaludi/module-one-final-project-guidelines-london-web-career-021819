require_relative '../config/environment'

def run
  greeting
  # pager = TTY::Pager.new
  # pager.page("Very long text...")
  user = login_or_register #needs to return the user
  menu_interaction(user)
end

def greeting
  puts "Hello, welcome to Pocket PT!"
  sleep(1)
  puts "Ready for some Flatiron abs?"
  sleep(1)
  print "Do you want workouts that leave you"
  3.times do
    sleep(0.5)
    print "."
  end
  puts "terminal?!"
  sleep(1)
  puts "Get it? Ok. I'll stop."
  sleep(0.8)
  puts `clear`
end

def login_or_register
  prompt = TTY::Prompt.new
  user_input = prompt.select("Would you like to register for the first time or sign in?",
  ["Register", "Sign in"])
  if user_input == "Register"
    user = User.register
  else
    user = User.login
  end
  user
end

def menu_interaction(user)
  prompt = TTY::Prompt.new
  selection = prompt.select("What you would like to do?",
    ["New Workout: A new workout will be generated for you",
      "Create your own workout: Choose exercises to create your own workout",
      "View your stats: Displays workouts done and total calories burnt",
      "Update your profile: Update your profile information",
      "View all upper body exercises available",
      "View all lower body exercises available",
      "View all cardio exercises available",
      "Change your password",
      "Exit: exits this program"])
  while selection != "Exit: exits this program"
    case selection
    when "New Workout: A new workout will be generated for you"
      user.generate_workout
    when "Create your own workout: Choose exercises to create your own workout"
      user.custom_workout
    when "View your stats: Displays workouts done and total calories burnt"
      user.user_stats
    when "Update your profile: Update your profile information"
      user.update_profile
    when "View all upper body exercises available"
      Exercise.display_exercises("Upper body")
    when "View all lower body exercises available"
      Exercise.display_exercises("Lower body")
    when "View all cardio exercises available"
      Exercise.display_exercises("Cardio")
    when "Change your password"
      user.change_password
    else
      exit_app
    end
    selection = prompt.select("What you would like to do?",
      ["New Workout: A new workout will be generated for you",
        "Create your own workout: Choose exercises to create your own workout",
        "View your stats: Displays workouts done and total calories burnt",
        "Update your profile: Update your profile information",
        "View all upper body exercises available",
        "View all lower body exercises available",
        "View all cardio exercises available",
        "Change your password",
        "Exit: exits this program"])
    end
  end

 def exit_app
   puts "Goodbye"

 end

run
