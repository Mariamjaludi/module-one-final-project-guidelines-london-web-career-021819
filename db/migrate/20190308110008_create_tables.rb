class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :age
      t.integer :weight
      t.string :gender
      t.string :goal, default: "Weight loss"
    end

    create_table :workouts do |t|
      t.string :goal
      t.string :workout_type
    end

  end
end
