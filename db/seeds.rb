
#dynamic users
mariam = User.create(username: "Mariam", password: "123456", age: 28, weight: 60, gender: "Female", goal: "Weight loss")
thomas = User.create(username: "Thomas", password: "123456", age: 29, weight: 80, gender: "Male", goal: "Muscle gain")
charly = User.create(username: "Charly", password: "123456", age: 28, weight: 55, gender: "Female", goal: "Endurance")
alex = User.create(username: "Alex", password: "123456", age: 29, weight: 85, gender: "Male", goal: "Muscle gain")
ali = User.create(username: "Ali", password: "123456", age: 25, weight: 79, gender: "Male", goal: "Muscle gain")
khang = User.create(username: "Khang", password: "123456", age: 25, weight: 70, gender: "Male", goal: "Endurance")
marju = User.create(username: "Marju", password: "123456", age: 28, weight: 55, gender: "Female", goal: "Endurance")

#9 static workouts
workout_1 = Workout.create(goal: "Weight loss", workout_type: "Upper body")
workout_2 = Workout.create(goal: "Muscle gain", workout_type: "Upper body")
workout_3 = Workout.create(goal: "Endurance", workout_type: "Upper body")
workout_4 = Workout.create(goal: "Weight loss", workout_type: "Lower body")
workout_5 = Workout.create(goal: "Muscle gain", workout_type: "Lower body")
workout_6 = Workout.create(goal: "Endurance", workout_type: "Lower body")
workout_4 = Workout.create(goal: "Weight loss", workout_type: "Cardio")
workout_5 = Workout.create(goal: "Muscle gain", workout_type: "Cardio")
workout_6 = Workout.create(goal: "Endurance", workout_type: "Cardio")

#static exercises
#lowerbody exercises
squat = Exercise.create(name: "Squat", description: "A compound, full-body exercise that trains primarily the muscles of the thighs,
  hips and buttocks, quadriceps femoris muscle, hamstrings, as well as strengthening the bones,
  ligaments and insertion of the tendons throughout the lower body.",exercise_type: "Lower body", avg_calories_burnt: 50)
leg_press = Exercise.create(name: "Leg Press", description: "A weight training exercise in which the individual pushes a weight or resistance away from them using their legs.", exercise_type: "Lower body", avg_calories_burnt: 35)
deadlift = Exercise.create(name: "Deadlift", description: "A weight training exercise in which a loaded barbell or bar is lifted off the ground to the level of the hips,
  then lowered to the ground.", exercise_type: "Lower body", avg_calories_burnt: 55)
leg_extension  = Exercise.create(name: "Leg Extension", description: "A resistance weight training exercise that targets the quadriceps muscle in the legs.
  The exercise is done using a machine called the Leg Extension Machine.", exercise_type: "Lower body", avg_calories_burnt: 40)
leg_curl = Exercise.create(name: "Leg Curl", description: "An isolation exercise that targets the hamstring muscles.
  The exercise involves flexing the lower leg against resistance towards the buttocks.", exercise_type: "Lower body", avg_calories_burnt: 45)
calf_raise  = Exercise.create(name: "Calf Raise", description: "A method of exercising the gastrocnemius, tibialis posterior and soleus muscles of the lower leg.
  The movement performed is plantar flexion, a.k.a. ankle extension.", exercise_type: "Lower body", avg_calories_burnt: 15)
lunge  = Exercise.create(name: "Lunge", description: "A lunge is a single-leg bodyweight exercise that works your hips, glutes, quads, hamstrings,
  core, and the hard-to-reach muscles of the inner thigh.", exercise_type: "Lower body", avg_calories_burnt: 40)
kettlebell_swing = Exercise.create(name: "Muscle Up", description: "Exhausting lower body exercise. Swing kettlebell repeatedly between legs keeping your arms and back straight and legs flexed", exercise_type: "Lower body", avg_calories_burnt: 88)

#upperbody exercises
bench_press = Exercise.create(name: "Bench Press", description: "A lifter lies on a bench with the feet on the floor and raises a weight with both arms.",exercise_type: "Upper body", avg_calories_burnt: 50)
bicep_curl = Exercise.create(name: "Bicep Curl", description: "An exercise targeting the biceps muscles, the muscles on the front of your upper arm.", exercise_type: "Upper body", avg_calories_burnt: 30)
pull_ups = Exercise.create(name: "Pull Up", description: "An upper-body compound pulling exercise. Although it can be performed with any grip.", exercise_type: "Upper body", avg_calories_burnt: 70)
tricep_extension = Exercise.create(name: "Tricep Extension", description: "A single-joint exercise that targets the triceps, the muscles on the back of your upper arm.", exercise_type: "Upper body", avg_calories_burnt: 50)
chest_fly = Exercise.create(name: "Chest fly", description: "A move that uses dumbbells to strengthen the muscles of the chest and arms in a different and complementary way to push-ups.", exercise_type: "Upper body", avg_calories_burnt: 35)
shoulder_raise = Exercise.create(name: "Shoulder Raise", description: "This exercise is an isolation exercise which isolates shoulder flexion.", exercise_type: "Upper body", avg_calories_burnt: 20)
sit_up = Exercise.create(name: "Sit up", description: "An abdominal endurance training exercise to strengthen and tone the abdominal muscles.", exercise_type: "Upper body", avg_calories_burnt: 50)
crunch = Exercise.create(name: "Crunch", description: "One of the most popular abdominal exercises. It primarily works the rectus abdominis muscle and also works the obliques.",exercise_type: "Upper body", avg_calories_burnt: 55)
plank = Exercise.create(name: "plank", description: "An exercise for strengthening your deep inner core: your transverse abdominis, multifidus, diaphragm, and pelvic floor.", exercise_type: "Upper body", avg_calories_burnt: 25)
ring_dip = Exercise.create(name: "Ring Dip", description: "An exercise for strengthening your triceps and chest. Hold on to gynastic rings and lower yourself before extending arms to return to starting position", exercise_type: "Upper body", avg_calories_burnt: 35)
muscle_up = Exercise.create(name: "Muscle Up", description: "Advanced calisthenic movement. True to its name, the muscle-up targets a large amount of muscle groupings in the back, shoulders, and the arms", exercise_type: "Upper body", avg_calories_burnt: 90)
shoulder_press = Exercise.create(name: "Shoulder Press", description: "A exercise performed with barbell or dumbells pressed overhead. Targets deltoids", exercise_type: "Upper Body", avg_calories_burnt: 35)

#cardio exercises
run_treadmill = Exercise.create(name: "Treadmill", description: "A device generally for walking or running or climbing while staying in the same place.
  Fun fact: Treadmills were originally invented as torture devices in prisons during the Victorian Era.", exercise_type: "Cardio", avg_calories_burnt: 120)
elliptical = Exercise.create(name: "Elliptical Machine", description: "A stationary exercise machine used to simulate stair climbing, walking,
  or running without causing excessive pressure to the joints, hence decreasing the risk of impact injuries.", exercise_type: "Cardio", avg_calories_burnt: 100)
stairclimber = Exercise.create(name: "Stair climber", description: "A stationary exercise machine used to simulate stair climbing. ", exercise_type: "Cardio", avg_calories_burnt: 150)
bike = Exercise.create(name: "Stationary Bicycle", description: "A stationary exercise machine used to simulate cycling.", exercise_type: "Cardio", avg_calories_burnt: 100)
jumprope = Exercise.create(name: "Jump rope", description: "A length of rope used for jumping by swinging it over the head and under the feet; a skipping rope.", exercise_type: "Cardio", avg_calories_burnt: 100)
burpees = Exercise.create(name: "Burpee", description: "A torturous exercise. A full body exercise used in strength training and as an aerobic exercise.
  The basic movement is performed in four steps and known as a 'four-count burpee': \nBegin in a standing position.\nMove into a squat position with your hands on the ground. (count 1) \nKick your feet back into a plank position, while keeping your arms extended. (count 2) \nImmediately return your feet into squat position. (count 3) \nlength of rope used for jumping by swinging it over the head and under the feet; a skipping rope.", exercise_type: "Cardio", avg_calories_burnt: 300)
rowing_machine = Exercise.create(name: "Rowing machine", description: "A stationary exercise machine used to simulate cycling.", exercise_type: "Cardio", avg_calories_burnt: 200)
ski_urg = Exercise.create(name: "Ski Urg", description: "Stationary machine with handles designed to imitate cross country skiing. Popular with the Norwegians.", exercise_type: "Cardio", avg_calories_burnt: 190)
