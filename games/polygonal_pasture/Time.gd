extends Control

signal harvest_over()

enum State {
	WAITING,
	HARVESTING,
	COMPLETE
}

var time_left = 0
var started_at = 0
var state

func _ready():
	time_left = 60.0
	started_at = Time.get_ticks_msec()
	state = State.WAITING

func _process(delta: float) -> void:
	if state != State.HARVESTING:
		return
	time_left -= delta
	$Left.text = "%d" % time_left
	$ColorRect.rect_scale = Vector2(time_left / 60.0, 1)
	if time_left <= 0.0:
		state = State.COMPLETE
		emit_signal('harvest_over')

func _start_countdown():
	state = State.HARVESTING
