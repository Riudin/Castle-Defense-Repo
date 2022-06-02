extends CanvasLayer

signal back_pressed
signal continue_pressed

onready var killcounter = get_node("VictoryScreenContainer/PanelContainer/MarginContainer/Rows/StageStats/StatValue/MobsKilled")
onready var time_display = get_node("VictoryScreenContainer/PanelContainer/MarginContainer/Rows/StageStats/StatValue/Time")


func _ready():
	get_tree().paused = true
	killcounter.text = str(get_parent().get_child(0).get_node("EnemySpawner").get_enemies_killed())
	var time = get_parent().get_child(0).get_playtime()
	time_display.text = get_parent().get_child(0).time_convert(time)


func _on_BackButton_pressed():
	get_tree().paused = false
	emit_signal("back_pressed")


func _on_ContinueButton_pressed():
	get_tree().paused = false
	emit_signal("continue_pressed")
