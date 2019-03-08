class CreateUsersWorkoutsAndExercisesTables < ActiveRecord::Migration[5.0]
  def change

    create_table :user_workouts do |t|
      t.integer :user_id
      t.integer :workout_id
      t.integer :total_calories
      t.string :date_of_workout
    end

    create_table :exercises do |t|
      t.string :name
      t.string :description
      t.string :exercise_type
      t.integer :avg_calories_burnt
    end

  end
end
