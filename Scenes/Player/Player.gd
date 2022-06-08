extends KinematicBody2D


signal game_finished(result)

onready var attack_origin = get_node("AttackOrigin")
#onready var wall = get_node("Wall")

##Variables influenced by player stats
#export(float) var damage = 1
#export(float) var agility = 1.5
#export(float) var health = 5
#export(float) var knockback = 5
#export(float) var mana = 5
#export(float) var critical_chance = 5
#export(float) var projectiles = 5
#export(float) var critical_damage = 5
#export(float) var spell_damage = 5
#export(float) var devastation = 5
#export(float) var gold = 5

var fire_rate = 1
 
var projectile = preload("res://Scenes/Weapons/IronSword.tscn")
var projectile_count = 1
var projectile_array = [0]
var can_fire = true

var touch_pos = Vector2()
var on_area = false


func _ready():
#	wall.connect("game_finished", get_parent().get_parent(), 'game_over')
#	wall.connect("game_finished", get_parent(), 'game_over')
	set_variables()
	create_projectile_array()


func _process(delta):
	if Input.is_action_pressed("attack") and can_fire:
		var projectile_direction = attack_origin.global_position.direction_to(touch_pos)
		if projectile_direction.x > 0:
			attack(projectile_direction)


func set_variables():
	fire_rate = 1 / GameData.player_data["agility"]


func create_projectile_array():
	projectile_count = GameData.player_data["projectile_count"]
	if projectile_count == 1:
		projectile_array = [0]
	elif projectile_count == 2:
		projectile_array = [-1.5, 1.5]
	elif projectile_count == 3:
		projectile_array = [-3, 0, 3]
	elif projectile_count == 4:
		projectile_array = [-4.5, -1.5, 1.5, 4.5]
	elif projectile_count == 5:
		projectile_array = [-6, -3, 0, 3, 6]


func _on_InputArea_pressed():
	on_area = true


func _on_InputArea_released():
	on_area = false


func _input(event):
	if on_area:
		if event is InputEventScreenTouch and event.is_pressed():
			touch_pos = event.get_position()
		
		elif event is InputEventScreenDrag:
			touch_pos = event.get_position()


func attack(projectile_direction: Vector2):
	for angle in projectile_array:
		
		if projectile:
			var projectile_instance = projectile.instance()
			get_tree().current_scene.add_child(projectile_instance)
			projectile_instance.global_position = attack_origin.global_position
			
			var projectile_instance_rotation = projectile_direction.angle()
			projectile_instance.rotation = projectile_instance_rotation + deg2rad(angle)
			
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true


#func _on_Hurtbox_area_entered(hitbox):
#	hitbox.get_parent().animation_player.play("attack")
#	take_damage(hitbox.damage)


func take_damage(dmg):
	GameData.player_data["health"] -= dmg
	if GameData.player_data["health"] > 0:
		get_parent().get_node("UI").update_health_bar(GameData.player_data["health"])
	else:
#		time_now = OS.get_unix_time()
#		playtime = time_now - time_start
#		print(playtime)
		get_parent().get_node("UI").update_health_bar(0)
		get_parent().get_node("UI/HUD/HealthAndMana/HealthManaBars/HP").value = 0
		emit_signal("game_finished", false)


func _on_Hurtbox_area_entered(hitbox):
	take_damage(hitbox.damage)
	#hitbox.get_parent().on_attack()
	#_on_Hurtbox_area_exited(hitbox)


func _on_Hurtbox_area_exited(hitbox):
	pass
#	print("enemy left the hurtbox", hitbox)
#	yield(get_tree().create_timer(hitbox.get_parent().attack_rate), "timeout")
#	if hitbox.get_parent() == null:
#		return
#	else:
#		_on_Hurtbox_area_entered(hitbox)
