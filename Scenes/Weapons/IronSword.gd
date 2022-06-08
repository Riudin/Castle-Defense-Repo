extends "res://Scenes/SupportScenes/Hitbox.gd"


signal deal_damage(dmg)

export var projectile_speed = 300
export (int) var projectile_damage = 1


func _ready():
	projectile_damage = GameData.player_data["damage"]
	self.add_to_group("Projectile")


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += projectile_speed * direction * delta

#
#func on_hit():
#	destroy()


func destroy():
	self.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	destroy()


func _on_IronSword_area_entered(area):
	destroy()
