extends AudioStreamPlayer

var batter : Node2D
var last_swing_power = 0
var half_max_swing_power = 50
var last_throw_power = 0
var click_interval = 5

func _ready():
	batter = get_parent()
	pass

func _process(delta):
	if (batter.current_state == batter.State.CROUCH):
		var current_throw_power = batter.throw_power
		var change_in_power = current_throw_power - last_throw_power
		if (change_in_power >= click_interval):  
			play()
			last_throw_power = current_throw_power
	
	if (batter.current_state == batter.State.WINDUP):
		var current_swing_power = batter.swing_power
		var change_in_power = current_swing_power - last_swing_power
		
		#var delta_from_center_of_max = current_swing_power - half_max_swing_power
		#var delta_from_center_as_percent_of_half = float(delta_from_center_of_max) / float(half_max_swing_power)
		#var sound_pitch = 1 + delta_from_center_as_percent_of_half # pitch will always range evenly from 0 to 2, based on the Z.
	
		# (1) normal line going out sound (thrown, or letting fish run)
		if (change_in_power >= click_interval):  
		#	pitch_scale = sound_pitch
			play()
			last_swing_power = current_swing_power
	#if (batter.current_state == batter.State.SWING):
	#	last_swing_power = 0 #quick and dirty way to reset
	pass
