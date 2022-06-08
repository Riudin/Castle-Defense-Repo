extends CanvasLayer


var hero_display_slot = load("res://Scenes/SupportScenes/HeroDisplaySlot.tscn")
onready var hero_container = get_node("M/HeroContainer")
onready var hero_inventory = get_parent().get_node("HeroInventory")

var hero_draw_chance = {
	"Fairy": 100
}

var drawn_heroes: Array = []


func draw_heroes(amount):
	for i in amount:
		var diceroll = rand_range(0, 100)
		if diceroll <= hero_draw_chance.Fairy:
			drawn_heroes.append("Fairy")
			HeroInventoryManager.add_hero("Fairy")
	display_heroes()


func display_heroes():
	for h in drawn_heroes.size():
		var new_hero_display_slot = hero_display_slot.instance()
		new_hero_display_slot.get_node("Hero").texture = load("res://Scenes/Heroes/Assets/HeroIcons/" + drawn_heroes[h] + ".png")
		hero_container.add_child(new_hero_display_slot)
	pass


func _on_BackButton_pressed():
	hero_inventory.initialize_inventory()
	queue_free()
