extends Node2D


onready var animation_player = get_node("AnimationPlayer")
onready var attack_origin = get_node("AttackOrigin")
onready var enemy_spawner = get_parent().get_parent().get_node("EnemySpawner")

var fire_rate = 1
var can_fire = true
var projectile_direction = Vector2.ZERO
 
var projectile = preload("res://Scenes/Heroes/FairyProjectile.tscn")

var nearest_enemy_position


func _ready():
	animation_player.play("Idle")


func _physics_process(delta):
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies != []:
		nearest_enemy_position = enemies[0].get_global_position()
		nearest_enemy_position -= Vector2(0, 12)
		projectile_direction = attack_origin.global_position.direction_to(nearest_enemy_position)
		
	else:
		projectile_direction = Vector2.ZERO
		
	if projectile_direction != Vector2.ZERO and can_fire:
		attack(projectile_direction)


func attack(projectile_direction: Vector2):
	if projectile:
		var projectile_instance = projectile.instance()
		get_tree().current_scene.add_child(projectile_instance)
		projectile_instance.global_position = attack_origin.global_position
		
		var projectile_instance_rotation = projectile_direction.angle()
		projectile_instance.rotation = projectile_instance_rotation
		
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
