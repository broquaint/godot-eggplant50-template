extends "res://games/dice_stanza/code/player/animgraph/ag_uber_player.gd"

func enter(data):
	return ._enter_state_climb(data)

func update(dt):
	return ._update_state_climb(dt)

func exit(_data):
	return true

