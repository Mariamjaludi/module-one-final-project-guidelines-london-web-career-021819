class Exercise < ActiveRecord::Base
  has_many :user_workout_exercises
  has_many :user_workouts, through: :user_workout_exercises

#takes in the user's choice of workout type to find the exercises
  def self.exercise_names(choice)
    exercises = Exercise.all.map do |exercise|
      if exercise.exercise_type == choice
        exercise.name
      end
    end
    exercises.compact
  end

  #displays exercises
  def self.display_exercises(workout_type)
    table_rows = []
    exercises = Exercise.all.select{|exercise| exercise.exercise_type == workout_type}

    exercises.each do |exercise|
      name = exercise.name
      description = exercise.description
      row = [name, description]
      table_rows << row
    end

    table = TTY::Table.new ["Exercise", "Description"], table_rows
    puts ""
    puts table.render(:unicode, multiline: true)
    puts ""
  end

#this will pick some exercises for our user
  def self.find_exercises(user_workout)
    #step 1: find out what kind of workout we are doing today (Lower body, upper body, or cardio)
    workout_type = user_workout.workout.workout_type
    #step 2: what is the user's goal? (Weight loss, Muscle gain, Endurance)
    goal = user_workout.user.goal
    #step 3: find 5 randomly selected exercises that match the type:
    todays_exercises = Exercise.all.select { |exercise| exercise.exercise_type == workout_type}.sample(5)
    #step 4: link the user's workout with the exercises
    todays_exercises.each do |exercise|
      current_userworkoutexercise = UserWorkoutExercise.create(
        user_workout_id: user_workout.id,
        exercise_id: exercise.id
      )
    end
    #step 5: lets find out how many sets and reps the user has to do based on their goal. This will call two functions (sets and reps) that will give the user custom sets and reps based on their goal.
    user_workout.user_workout_exercises.each do |uwe|
      uwe.sets = sets(goal)
      uwe.reps = reps(goal)
    #step 6: calculate how many calories were burnt for each exercise based on the user's goal.
      uwe.custom_calories = uwe.exercise.custom_calories(goal)
    end
    user_workout.set_total_calories
  end

  #this method will calculate how many sets to do for an exercise based on the user's goal.
  def self.sets(goal)
    if goal == "Weight loss"
      sets = rand(2..4)
    elsif goal == "Muscle gain"
      sets = rand(4..10)
    else
      sets = 1
    end
    sets
  end
  #this method will calculate how many reps to do for an exercise based on the user's goal.
  def self.reps(goal)
    if goal == "Weight loss"
      reps = rand(15..25)
    elsif goal == "Muscle gain"
      reps = rand(4..8)
    else
      reps = 20

    end
    reps
  end

#this method will calculate how many calories are burnt based on the user's goal.
  def custom_calories(goal)
    if goal == "Weight loss"
      custom_calories = self.avg_calories_burnt * 1.2
    elsif goal == "Endurance"
      custom_calories = self.avg_calories_burnt * 1.5
    else
      custom_calories = self.avg_calories_burnt
    end
    custom_calories
  end


  # def self.find_exercises_by_cal_goal(user_workout, cal_goal)
  #   workout_type = user_workout.workout.workout_type
  #   goal = user_workout.user.goal
  #   todays_exercises = Exercise.all.select { |exercise| exercise.exercise_type == workout_type}.sample(10)
  #   cal_sum = 0
  #   todays_exercises.each do |exercise|
  #     if cal_sum < cal_goal
  #     current_userworkoutexercise = UserWorkoutExercise.create(user_workout_id: user_workout.id, exercise_id: exercise.id)
  #     current_userworkoutexercise.update(sets: sets(goal), reps: reps(goal), custom_calories: uwe.exercise.custom_calories(goal))
  #     cal_sum +=
  #   end
  #   user_workout.user_workout_exercises.each do |uwe|
  #     uwe.sets = sets(goal)
  #     uwe.reps = reps(goal)
  #     uwe.custom_calories = uwe.exercise.custom_calories(goal)
  #   end
  #   user_workout.set_total_calories
  #
  #   while user_workout.total_calories < cal_goal
  #     exercise = Exercise.all.select { |exercise| exercise.exercise_type == workout_type}.sample
  #     uwe = UserWorkoutExercise.create(user_workout_id: user_workout.id, exercise_id: exercise.id)
  #     uwe.sets = sets(goal)
  #     uwe.reps = reps(goal)
  #     uwe.custom_calories = uwe.exercise.custom_calories(goal)
  #     user_workout.set_total_calories
  #         binding.pry
  #   end
  # end
end
