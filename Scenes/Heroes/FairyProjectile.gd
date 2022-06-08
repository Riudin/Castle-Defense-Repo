extends "res://Scenes/SupportScenes/Hitbox.gd"


export (int) var projectile_speed = 300
export (int) var projectile_damage = 1

onready var only_once = true # this makes it so the body entered function can only run once per projectile

func _ready():
	self.add_to_group("Projectile")


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += projectile_speed * direction * delta


func destroy():
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	destroy()


func _on_FairyProjectile_body_entered(enemy):
	if only_once:
		only_once = false
		enemy.take_damage(projectile_damage)
	destroy()
