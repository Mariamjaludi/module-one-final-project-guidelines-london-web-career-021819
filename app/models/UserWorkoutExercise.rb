class UserWorkoutExercise < ActiveRecord::Base
belongs_to :user_workout
belongs_to :exercise


end
