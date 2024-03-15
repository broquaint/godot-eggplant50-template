extends Sprite

var outs = 0
var strikes = 0
var runs = 0

func increase_runs ():
	runs += 1
	#tbd: some sort of animation
	pass
	
func reset_runs ():
	runs = 0
	#tbd: some sort of animation
	pass

func increase_strikes():
	strikes += 1
	#tbd: some sort of animation
	pass
	
func reset_strikes ():
	strikes = 0
	#tbd: some sort of animation
	pass
	
func increase_outs():
	outs += 1
	#tbd: some sort of animation
	pass
	
func reset_outs():
	outs = 0
	#tbd: some sort of animation
	pass

func new_out ():
	increase_outs()
	reset_strikes()
	#if 3 outs, game over
	if (outs >= 3) :
		print("that's three outs")
		#TBD: show game over screen
		reset_runs()
		reset_outs()
		reset_strikes()
		gameover_sound()
	else:
		yield(get_tree().create_timer(0.5), "timeout")
		get_node("out_sound").play()
	update_display()
	pass
	
func new_strike ():
	increase_strikes() #increment strikes
	#if 3 strikes, reset strikes, increment outs
	if (strikes >= 3) :
		print("that's three strikes")
		new_out()
		reset_strikes()
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("strike_sound").play()
	update_display()
	pass

func new_run ():
	increase_runs()
	reset_strikes()
	# update display
	get_node("Homeruns").set_text(str(runs))
	yield(get_tree().create_timer(0.5), "timeout")
	update_display()
	pass

func gameover_sound():
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("gameover_sound").pitch_scale = 1
	get_node("gameover_sound").play()
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("gameover_sound").pitch_scale -= 0.4
	get_node("gameover_sound").play()
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("gameover_sound").pitch_scale -= 0.4
	get_node("gameover_sound").play()
	
func update_display ():
	if (strikes >= 1):
		get_node("strike_one").set_text("X")
	else :
		get_node("strike_one").set_text("")
	
	if (strikes >= 2):
		get_node("strike_two").set_text("X")
	else :
		get_node("strike_two").set_text("")
		
	if (strikes >= 3):
		get_node("strike_three").set_text("X")
	else :
		get_node("strike_three").set_text("")
	
	if (outs >= 1):
		get_node("out_one").set_text("X")
	else :
		get_node("out_one").set_text("")
		
	if (outs >= 2):
		get_node("out_two").set_text("X")
	else :
		get_node("out_two").set_text("")
		
	if (outs >= 3):
		get_node("out_three").set_text("X")
	else :
		get_node("out_three").set_text("")

func _ready():
	update_display()
	pass

func _process(delta):
	pass
