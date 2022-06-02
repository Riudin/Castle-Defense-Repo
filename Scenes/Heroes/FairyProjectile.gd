extends Area2D


export (int) var projectile_speed = 300
export (int) var projectile_damage = 1


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += projectile_speed * direction * delta


func destroy():
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_FairyProjectile_area_entered(area):
	destroy()
