extends KinematicBody2D


#signal wall_damage(damage)
signal enemy_killed()
signal dealt_damage(damage)

var speed = 20
var health = 4
var wall_damage = 2
var attack_rate = 1
var gold_drop = 2
var x_pos = self.position.x

var can_attack = true
var is_alive = true

onready var hitbox = get_node("Hitbox")
onready var animation_player = get_node("AnimationPlayer")
#onready var hurtbox = get_node("Hurtbox")
onready var health_bar = get_node("HealthBar")
onready var attack_rate_timer = get_node("AttackRateTimer")
onready var enemy_spawner = get_parent().get_parent()


func _ready():
	gold_drop += round(rand_range(enemy_spawner.current_stage / 5, enemy_spawner.current_stage / 2))
	health += round(enemy_spawner.current_stage * 1.2)
	wall_damage += round(enemy_spawner.current_stage / 10)
	hitbox.set_damage(wall_damage)
	attack_rate_timer.wait_time = attack_rate
	health_bar.max_value = health
	health_bar.value = health
	animation_player.play("move")



func _physics_process(delta):
	if is_alive:
		move(delta)


#func _on_AttackRateTimer_timeout():
#	if GameData.player_data["health"] <= 0:
#		can_attack = false
#	elif get_node("Hitbox").overlaps_area(get_parent().get_parent().get_parent().get_node("Player/Wall/Hurtbox")) and can_attack:
#		emit_signal("wall_damage", wall_damage)


func move(delta):
	var collision = move_and_collide(Vector2.LEFT * speed * delta)
	if collision and can_attack:
		emit_signal("dealt_damage", wall_damage)
		can_attack = false
		yield(get_tree().create_timer(attack_rate), "timeout")
		can_attack = true



func _on_Hurtbox_area_entered(hostile_hitbox):
	if is_alive:
		health -= hostile_hitbox.damage
		health_bar.visible = true
		health_bar.value = health
		if health <= 0:
			on_destroy()


func on_destroy():
	is_alive = false
	GameData.player_data["gold"] += gold_drop
	emit_signal("enemy_killed")
	self.queue_free()

