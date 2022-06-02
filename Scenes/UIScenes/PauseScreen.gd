extends CanvasLayer


signal restart_pressed
signal quit_pressed


func _ready():
	GameData.save_game()
	get_tree().paused = true


func _on_ContinueButton_pressed():
	get_tree().paused = false
	self.queue_free()


func _on_RestartButton_pressed():
	get_tree().paused = false
	emit_signal("restart_pressed")


func _on_QuitButton_pressed():
	get_tree().paused = false
	emit_signal("quit_pressed")
