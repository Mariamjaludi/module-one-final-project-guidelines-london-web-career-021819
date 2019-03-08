class UserWorkout < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout

  has_many :user_workout_exercises
  has_many :exercises, through: :user_workout_exercises


  def display_exercises
    #get all the exercises for this user workout.
    #go through each exercise and print it.
    #find the matching sets, reps, and calories for that user_workout and exercise.
    # i = 1
    puts "\n"
    puts "Today you are doing a(n) #{self.workout.workout_type} workout!"
    table_rows = []
    self.user_workout_exercises.each do |uwe|
      name = uwe.exercise.name
      reps = uwe.reps
      sets = uwe.sets
      cal = uwe.custom_calories

      row = [name, sets, reps, cal]
      table_rows << row
    end
    table = TTY::Table.new ["Exercise", "Sets", "Reps", "Avg. Calories Burnt"], table_rows
    puts "\n"
    puts table.render(:unicode, alignments: [:center, :center, :center, :center])
    puts "\n"
  end
#sets the total calories of a user_workout
  def set_total_calories
    sum_of_cal = 0
    self.user_workout_exercises.each { |uwe| sum_of_cal += uwe.custom_calories}
    self.update(total_calories: sum_of_cal)
  end

#displays the total calories of a user workout
 def display_total_calories_per_workout
   puts "This workout will burn an average of #{self.total_calories} calories."
 end
end
