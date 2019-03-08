class CreateUserWorkoutExercisesTable < ActiveRecord::Migration[5.0]
  def change

    create_table :user_workout_exercises do |t|
      t.integer :user_workout_id
      t.integer :exercise_id
      t.integer :sets
      t.integer :reps
      t.integer :custom_calories
    end
    
  end
end
