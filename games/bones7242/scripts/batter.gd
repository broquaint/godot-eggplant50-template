extends Node2D

const State = {IDLE = 0, CROUCH = 1, RELEASE = 2, WINDUP = 3, SWING = 4, FOLLOWTHROUGH = 5}
# Access values with State.HELD, etc.

var initial_state = State.IDLE
var current_state : int
var last_state : int

var spr_batter_idle = preload("../sprites/idle.png")
var spr_batter_crouch = preload("../sprites/crouch.png")
var spr_batter_release = preload("../sprites/release.png")
var spr_batter_windup = preload("../sprites/windup.png")
var spr_batter_swing = preload("../sprites/swing.png")
var spr_batter_followthrough = preload("../sprites/followthrough.png")

var min_throw_power  = 0
var throw_power = min_throw_power
var max_throw_power = 100
var throw_power_increment = 1

var min_swing_power  = 0
var swing_power = min_swing_power
var max_swing_power = 100
var swing_power_increment = 1

var delta_counter = 0

func change_state(new_state):
	# store the current state as last state, if it exists
	if current_state:
		last_state = current_state
	
	delta_counter = 0
	current_state = new_state
	pass

func check_for_hit():
	#get position of ball
	var baseball_object = $"../baseball_area2d"
	var bat_object = $"../bat_area2d"
	#see if ball within radius of hitting sphere
	#var distance_to_ball_center = bat_object.position.distance_to(baseball_object.position)
	var x_diff = baseball_object.position.x - bat_object.position.x
	var y_diff = baseball_object.position.y - bat_object.position.y
	print('x distance to ball = ' + str(x_diff))
	print('y distance to ball = ' + str(y_diff))
	#return true
	var y_inside = (y_diff <= 30 && y_diff >=0)
	var x_inside = (x_diff <= 50 && x_diff >=0)
	return (y_inside && x_inside)
	

func _ready():
	change_state(initial_state)
	get_node("Sprite").set_texture(spr_batter_idle)
	pass
	
func _process(delta):
	delta_counter += delta
	
	match current_state:
		State.IDLE:
			#print("i am HELD")
			#wait around
			#listen for change to windup
			if Input.is_action_pressed("action1"):
				change_state(State.CROUCH)
				get_node("Sprite").set_texture(spr_batter_crouch)
				get_node("snd_click").last_throw_power = throw_power
		State.CROUCH:
			# build up power
			if throw_power < max_throw_power:
				throw_power += throw_power_increment
				print("throw power = " + str(throw_power))
			# listen for release
			if Input.is_action_just_released("action1"):
				change_state(State.RELEASE)
				get_node("Sprite").set_texture(spr_batter_release)
				# affect the ball
				var ball = get_parent().get_node("baseball_area2d")
				ball.change_state_released(throw_power) # change state
				throw_power = min_throw_power # reset
				get_node("snd_release").play()
		State.RELEASE:
			if Input.is_action_pressed("action1"):
				change_state(State.WINDUP)
				swing_power = min_swing_power
				get_node("Sprite").set_texture(spr_batter_windup)
				get_parent().get_node("bat_area2d").visible = true
				get_node("snd_click").last_swing_power = swing_power
		State.WINDUP:
			# build up power
			if swing_power < max_swing_power:
				swing_power += swing_power_increment
			# print("swing power = " + str(swing_power))
			#listen for change to released
			if Input.is_action_just_released("action1"):
				change_state(State.SWING)
				get_node("Sprite").set_texture(spr_batter_swing)
		State.SWING:
			# check if a hit, 
			# if so, then initiate the hit state on baseball
			if check_for_hit():
				print("YOU GOT A HIT!")
				#to do: affect the ball
				get_parent().get_node("baseball_area2d").hit(swing_power) # change state
			if (delta_counter > 0.1) :
				change_state(State.FOLLOWTHROUGH)
				get_node("Sprite").set_texture(spr_batter_followthrough)	
			
		State.FOLLOWTHROUGH:
			#when ball hits the floor...
			var ball = get_parent().get_node("baseball_area2d")
			if ball.current_state == ball.State.GROUNDED :
				if (delta_counter > 1) :
					change_state(State.IDLE)
					get_parent().get_node("baseball_area2d").change_state_held() # change state
					get_node("Sprite").set_texture(spr_batter_idle)
					get_parent().get_node("bat_area2d").visible = false
		_:
			print("I am not a bat state I know of!")
		
	#print('power:' + str(power))
	update()
	
#func _draw () :
#	draw_rect(Rect2(40, 50, 60, 50), Color("#39855a"))
#	pass
