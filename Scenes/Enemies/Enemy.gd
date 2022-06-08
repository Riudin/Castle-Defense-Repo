extends KinematicBody2D
class_name Enemy

### maybe remove attackratetimer object later

signal enemy_killed()

var speed = 20
var health: float = 4
var damage = 2
var attack_rate = 1
var gold_drop = 2
var x_pos = self.position.x

var can_attack = true setget set_can_attack

onready var hitbox = get_node("Hitbox")
onready var animation_player = get_node("AnimationPlayer")
onready var health_bar = get_node("HealthBar")
onready var attack_rate_timer = get_node("AttackRateTimer")
onready var enemy_spawner = get_parent().get_parent()


func _ready():
	set_variables()


func _physics_process(delta):
	move(delta)


func set_variables():
	gold_drop += round(rand_range(enemy_spawner.current_stage / 5, enemy_spawner.current_stage / 2))
	health *= pow(1.064, enemy_spawner.current_stage)   #round(enemy_spawner.current_stage * 1.2)
	health = int(health) # not sure yet if we want health only as ints
	damage += round(enemy_spawner.current_stage / 10)
	hitbox.set_damage(damage)
	attack_rate_timer.wait_time = attack_rate
	health_bar.max_value = health
	health_bar.value = health


func set_can_attack(b: bool):
	can_attack = b
	attack_rate_timer.start()
	yield(attack_rate_timer, "timeout")
	can_attack = !can_attack


func move(delta):
	var _collision = move_and_collide(Vector2.LEFT * speed * delta)
	animation_player.play("move")


func on_attack():
	pass


func take_damage(dmg):
	health -= dmg
	health_bar.visible = true
	health_bar.value = health
	if health <= 0:
		on_destroy()


func on_destroy():
	attack_rate_timer.stop()
	GameData.player_data["gold"] += gold_drop
	emit_signal("enemy_killed")
	queue_free()

