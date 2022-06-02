extends KinematicBody2D


signal wall_damage(damage)
signal enemy_killed()

var speed = 20
var health = 4
var wall_damage = 2
var attack_rate = 1
var gold_drop = 2

var can_attack = true
var is_alive = true

onready var hurtbox = get_node("Hurtbox")
onready var health_bar = get_node("HealthBar")
onready var attack_rate_timer = get_node("AttackRateTimer")
onready var enemy_spawner = get_parent().get_parent()


func _ready():
	gold_drop += round(rand_range(enemy_spawner.current_stage / 5, enemy_spawner.current_stage / 2))
	health += round(enemy_spawner.current_stage * 1.2)
	wall_damage += round(enemy_spawner.current_stage / 10)
	attack_rate_timer.wait_time = attack_rate
	health_bar.max_value = health
	health_bar.value = health


func _physics_process(delta):
	move(delta)


func _on_AttackRateTimer_timeout():
	if GameData.player_data["health"] <= 0:
		can_attack = false
	elif get_node("Hitbox").overlaps_area(get_parent().get_parent().get_parent().get_node("Wall/Hurtbox")) and can_attack:
		emit_signal("wall_damage", wall_damage)


func move(delta):
	move_and_collide(Vector2.LEFT * speed * delta)


func _on_Hurtbox_area_entered(_area):
	if is_alive:
		health -= GameData.player_data["damage"]
		health_bar.visible = true
		health_bar.value = health
		if health <= 0:
			on_destroy()


func on_destroy():
	is_alive = false
	GameData.player_data["gold"] += gold_drop
	emit_signal("enemy_killed")
	self.queue_free()

