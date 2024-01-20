extends Node2D

var InkPlayerFactory := preload("res://addons/inkgd/ink_player_factory.gd") as GDScript
var _ink_player = InkPlayerFactory.create()

export var ink_file: Resource

#onready var _ink_player = $InkPlayer

func _ready():
	add_child(_ink_player)

	_ink_player.ink_file = ink_file

	_ink_player.connect("loaded", self, "_story_loaded")
	_ink_player.connect("continued", self, "_continued")
	_ink_player.connect("prompt_choices", self, "_prompt_choices")
	_ink_player.connect("ended", self, "_ended")

	print("creating story ...")
	_ink_player.create_story()

func _story_loaded(successfully: bool):
	if !successfully:
		return

	print("continuing story for ")
	_ink_player.continue_story()

func _should_show_debug_menu(debug):
	# Contrived external function example, where
	# we just return the pre-existing value.
	print("_should_show_debug_menu called")
	return debug

func _continued(text, _tags):
	print("Story text: ", text)
	$StoryText.text = text
	_ink_player.continue_story()

func _prompt_choices(choices):
	if !choices.empty():
		print(choices)

		for idx in range(choices.size()):
			var choice_text = choices[idx]
			print(choice_text)
			var choice = Button.new()
			choice.text = choice_text
			choice.connect('pressed', self, '_select_choice', [idx])
			print('added ', choice, ' at index ', idx)
			$Choices.add_child(choice)
	# In a real-world scenario, _select_choice' could be
	# connected to a signal, like 'Button.pressed'.
#	_select_choice(0)

func _ended():
	print("The End")
	$StoryText.text = 'The End'

func _select_choice(index):
	print("Selected choice ", index)
	_ink_player.choose_choice_index(index)
	_ink_player.continue_story()

func x_continue_story():
	var text = _ink_player.continue_story()

	# This text is a line of text from the ink story.
	# Set the text of a Label to this value to display it in your game.
	print(text)
	$StoryText.text = text

	if _ink_player.has_choices:
		$Choices.clear()
		# 'current_choices' contains a list of the choices, as strings.
		for idx in range(_ink_player.current_choices.size()):
			var choice_text = _ink_player.current_choices[idx]
			print(choice_text)
			var choice = Button.new()
			choice.text = choice_text
			choice.connect('pressed', self, '_select_choice', [idx])
			$Choices.add_child(choice)
	else:
		# This code runs when the story reaches it's end.
		print("The End")
		$StoryText.text = 'The End'
		
