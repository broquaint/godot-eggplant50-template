extends Node2D

func _ready() -> void:
	$Pasture.connect('plot_enter', $Farmer, 'on_plot_enter')
	$Pasture.connect('plot_exit',  $Farmer, 'on_plot_exit')
	$Pasture.connect('shape_gathered', $Basket, 'on_shape_gathered')
	$Pasture.connect('shape_gathered', $UI/Status, 'on_shape_gathered')
	$Basket.connect('shape_ready_to_collect', $Distribution, 'on_shape_ready_to_collect')
	$Basket.connect('shape_ready_to_collect', $UI/Status, 'on_score_update')
	$Farmer.connect('seed_change', $UI/Status, 'on_seed_change')

	$UI/Welcome.connect('confirmed', $Farmer, '_start_harvest')
	$UI/Welcome.connect('confirmed', self, '_start_music')
	$UI/Welcome.connect('confirmed', $UI/Time, '_start_countdown')
	$UI/Time.connect('harvest_over', self, '_on_harvest_over')
	$UI/Welcome.popup_centered()

func _on_harvest_over():
	var summary = $UI/GameOver.dialog_text
	summary = summary.replace('XXX', str($UI/Status.gathered))
	summary = summary.replace('YYY', str($UI/Status.mergers))
	summary = summary.replace('ZZZ', str($UI/Status.total_score))
	$UI/GameOver.dialog_text = summary
	$UI/GameOver.get_ok().visible = false
	$UI/GameOver.rect_size.y = 100
	$UI/GameOver.popup()

	$PauseMenu.popup_without_continue()
	$PauseMenu.get_node('%InputDisplay').visible = false
	get_tree().paused = true

func _start_music():
	$AudioStreamPlayer.play()
