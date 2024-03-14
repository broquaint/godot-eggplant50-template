extends AudioStreamPlayer

var ball : Node2D
var last_ball_z : int
var half_max_z_depth = 200
var reel_click_interval = 5

func _ready():
	ball = get_parent()
	last_ball_z = ball.unprojectedZ
	pass

func _process(delta):
	if (ball.current_state == ball.State.RELEASED):
		if (ball.unprojectedZ <= 5):
			last_ball_z = ball.unprojectedZ #should reset in a better way
			pass
		else :
			var current_ball_z = ball.unprojectedZ
			var change_in_z = current_ball_z - last_ball_z
			
			var _z_delta_from_center_of_max_z = current_ball_z - half_max_z_depth;
			var _z_delta_from_center_as_percent_of_half = _z_delta_from_center_of_max_z / half_max_z_depth * 2 / 3;
			var _sound_pitch = 1 + _z_delta_from_center_as_percent_of_half; # pitch will always range evenly from 0 to 2, based on the Z.
		
			# (1) normal line going out sound (thrown, or letting fish run)
			if (change_in_z >= reel_click_interval):  
				pitch_scale = _sound_pitch
				play()
				last_ball_z = current_ball_z
	pass
