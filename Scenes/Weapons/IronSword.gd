extends KinematicBody2D


onready var hitbox = get_node("Hitbox")

export var projectile_speed = 300
export (int) var projectile_damage = 1


func _ready():
	projectile_damage = GameData.player_data["damage"]
	hitbox.set_damage(projectile_damage)


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += projectile_speed * direction * delta


func destroy():
	queue_free()


func _on_IronSword_area_entered(area):

	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
