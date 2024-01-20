extends ScrollContainer

var message_seen = []
func _ready():
	pass
#	$List.remove_child($List/PlaceHolder)

func message_received(message):
	if $List.has_node('PlaceHolder'):
		$List.remove_child($List/PlaceHolder)

	if not message_seen.empty():
		$List.add_child(HSeparator.new())

	message_seen.append(message)

	var entry = Label.new()
	# Mostly useless but at least adds a few pixels of LHS space!
#	entry.add_spacer(true)
#	entry.get_node("Source").bbcode_text = '[b]%s[/b]' % source
	entry.autowrap = true
	entry.text = message
	entry.margin_left = 6.0
	$List.add_child(entry)
	
	# via https://github.com/godotengine/godot-proposals/issues/3629
	yield(get_tree(), "idle_frame")
	ensure_control_visible(entry)
