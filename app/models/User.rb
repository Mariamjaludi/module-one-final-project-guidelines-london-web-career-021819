
class User < ActiveRecord::Base
  has_many :user_workouts
  has_many :workouts, through: :user_workouts

  #this method registers the user on the application
  def self.register
    prompt = TTY::Prompt.new
    username = prompt.ask("Please enter a username: ")
    password = prompt.mask("Please enter a password: ") #hides the password while its being entered
    username_check = User.all.find_by(username: username) #check if user already exists
    if username_check != nil
      puts "That username already exists. Please try another username."
      User.register
    else
      user = User.create(username: username, password: password)
      bar = TTY::ProgressBar.new("Registering [:bar]", total: 50)
      50.times do
        sleep(0.05)
        bar.advance(1)
      end
      puts "Sucess! You are now registered!"
      sleep(1.5)
      puts `clear`
      puts "Lets create your profile"
      user.update_profile
    end
    user
  end

  #this method logs in an existing user
  def self.login
    prompt = TTY::Prompt.new
    username = prompt.ask("Please enter your username: ")
    password = prompt.mask("Please enter your password: ")
    auth = authenticate_username(username)
    if auth == nil
      puts "User does not exist! Please try again"
      login
    else
      user = authenticate_password(username, password)
      if user == nil
        puts "Incorrect password. Please try again."
        login
      else
        bar = TTY::ProgressBar.new("Logging in [:bar]", total: 50)
        50.times do
          sleep(0.05)
          bar.advance(1)
        end
        sleep(0.5)
        puts "Login sucess!"
        #user.last_login = datetime #update last login time
      end
      sleep(1.5)
      puts `clear`
      user
    end

  end

  #this method checks if the username exists
  def self.authenticate_username(username)
    User.all.find_by(username: username)
  end
#this method checks if the password matches for an existing username
  def self.authenticate_password(username, password)
    User.all.find_by(username: username, password: password)
  end

#this method gets/updates the fitness goal of the user
  def update_goal
    prompt = TTY::Prompt.new
    goal = prompt.select("What is your fitness goal?", ["Weight loss", "Muscle gain", "Endurance"])
    self.update(goal: goal)
  end

  #this method gets/updates all of the user attributes.
  def update_profile
    prompt = TTY::Prompt.new

    selection = prompt.select("What would you like to update?",
    ["Age", "Weight", "Gender", "Fitness Goal", "Return to main menu"])
    while selection != "Return to main menu"
      case selection
      when "Age"
        age = prompt.ask("Please enter your age:")
        self.update(age: age)
      when "Weight"
        weight = prompt.ask("Please enter your weight:")
        self.update(weight: weight)
      when "Gender"
        gender = prompt.ask("Please enter your gender:")
        self.update(gender: gender)
      when "Fitness Goal"
      update_goal
      end
    selection = prompt.select("What would you like to update?",
    ["Age", "Weight", "Gender", "Fitness Goal", "Return to main menu"])
    end
    sleep(1.5)
    puts `clear`
  end

  def generate_workout
    #step 1: get the user's goal (Weight loss, Muscle gain, Endurance)
    goal = self.goal
    #step 2: generate a workout type for today (Upper body, Lower body, Cardio) it will call a function that will randomly choose a type.
    workout_type = random_workout_type
    #step 3: find a workout that matches the goal and type
    todays_workout = Workout.all.find { |workout| workout.goal == goal && workout.workout_type == workout_type}
    #step 4: link the user to the workout
    new_userworkout = UserWorkout.create(
      user_id: self.id,
      workout_id: todays_workout.id,
      date_of_workout: Date.today
    )
    #step 5: Choose some exercises for the user based on workout_type it will call a class method in Exercise that will choose some exercises
    Exercise.find_exercises(new_userworkout)
    #step 6: display the workout to the user. calls a method to display the workout.
    bar = TTY::ProgressBar.new("Generating today's workout [:bar]", total: 50)
    50.times do
      sleep(0.05)
      bar.advance(1)
    end
    new_userworkout.display_exercises
    new_userworkout.display_total_calories_per_workout
    prompt = TTY::Prompt.new
    prompt.ask("Press any key to return to the main menu.")
    puts `clear`
  end

  def custom_workout
    #step 1: get user's choice of workout type
    prompt = TTY::Prompt.new
    workout_type = prompt.select("Please choose what type of workout you would like to do today:",
    ["Upper body", "Lower body", "Cardio"])
    #binding.pry
    #step 2: find the workout that matches type and goal.
    todays_workout = Workout.all.find {|workout| workout.goal == self.goal && workout.workout_type == workout_type}
    #step 3: link the user to the workout
    new_userworkout = UserWorkout.create(
      user_id: self.id,
      workout_id: todays_workout.id,
          date_of_workout: Date.today
    )

      todays_workout = Workout.all.find { |workout| workout.goal == goal && workout.workout_type == workout_type}
    #step 4: ask the user to choose their exercises:
    exercise_names = Exercise.exercise_names(workout_type)
    exercise_names << "Done"
    prompt = TTY::Prompt.new
    exercise_set = []
    selection = prompt.select("Please choose your exercises. Choose 'Done' once you've chosen all of your exercises", exercise_names)
    while selection != "Done"
      #step 5: add exercise to an array
      found_exercise = Exercise.all.find{ |exercise| exercise.name == selection}
      exercise_set << found_exercise
      selection = prompt.select("Choose your next exercise. Choose 'Done' once you've chosen all of your exercises", exercise_names)
    end
    #step 6: link the exercises to the user's workout.
    exercise_set.each do |exercise|
        current_userworkoutexercise = UserWorkoutExercise.create(
          user_workout_id: new_userworkout.id,
          exercise_id: exercise.id
        )
    end
      #step 7: lets find out how many sets and reps the user has to do based on their goal.
      #This will call two functions (sets and reps) that will give the user custom sets and reps based on their goal.
    new_userworkout.user_workout_exercises.each do |uwe|
      uwe.sets = Exercise.sets(goal)
      uwe.reps = Exercise.reps(goal)
    #step 6: calculate how many calories were burnt for each exercise based on the user's goal.
      uwe.custom_calories = uwe.exercise.custom_calories(goal)
    end
    new_userworkout.set_total_calories
    #progress bar for effect
    bar = TTY::ProgressBar.new("Generating your custom workout [:bar]", total: 50)
    50.times do
      sleep(0.05)
      bar.advance(1)
    end
    #step 7: return the user's workout's exercises.
    new_userworkout.display_exercises
    new_userworkout.display_total_calories_per_workout

    prompt.ask("Press any key to return to the main menu.")
    puts `clear`
  end

  def random_workout_type
    rand_num = rand(2)
    if rand_num == 0
      workout_type = "Upper body"
    elsif rand_num == 1
      workout_type = "Lower body"
    else
      workout_type = "Cardio"
    end
    workout_type
  end

  def change_password
    prompt = TTY::Prompt.new
    password = prompt.mask("Please enter your current password:")
    username = self.username
    check = User.authenticate_password(username, password)
    if check == nil
      puts "Incorrect password. Please try again."
      change_password
    else
      password_match = ""
      while password_match != password
        password = prompt.mask("Please enter a new password:") #hides the user's pass while its entered
        password_match = prompt.mask("Please enter your new password again:")
        if password == password_match
          self.password = password
          self.update(password: password)
          bar = TTY::ProgressBar.new("Updating password [:bar]", total: 50)
          50.times do
            sleep(0.05)
            bar.advance(1)
          end
          puts "Your password has been updated."
        else
          puts "Your new password entries do not match. Please try again."
        end
      end

    end
      puts `clear`
  end

  def user_stats
      display_profile_info #displays weight, fitness goal.
      display_all_workouts #display user workouts
      puts "You have done a total of #{self.user_workouts.length} workouts!"
      puts "You have burnt a total of #{self.total_calories_all_workouts} calories since starting your journey with us!"
      puts "Fantastic Progress! Keep it up!"
      prompt = TTY::Prompt.new
      prompt.ask("Press any key to return to the main menu.")
      puts `clear`
  end

  def display_profile_info
    table = TTY::Table.new ["Fitness Goal", "Current Weight"], [[self.weight, self.goal]]
    table = table.render(:ascii)
    puts table
  end

  def display_all_workouts
    table_rows = []
    user_workouts.each do |user_workout|
      total_cal = user_workout.total_calories
      date =  user_workout.date_of_workout
      type = user_workout.workout.workout_type
      row = [date, type, total_cal]
      table_rows << row
    end
    table = TTY::Table.new ["Date of Workout", "Workout Type", "Total Calories Burnt"], table_rows
    table = table.render(:ascii)
    puts table
  end

  def total_calories_all_workouts
    sum = 0
    self.user_workouts.each {|user_workout| sum += user_workout.total_calories}
    sum
  end

end
