extends Panel
class_name Slot_Class


const hero_display_scene = preload("res://Scenes/Heroes/HeroDisplay.tscn")
var hero = null
var slot_index

enum SlotType {
	INVENTORY,
	EQUIPPED
}

var slotType = null

### Functionality to change slot background depending on if there is an item or not
### not implementet since not needed.


#func _ready():
#	if randi() % 2 == 0:
#		item = ITEM_CLASS.instance()
#		add_child(item)


func pick_from_slot():
	remove_child(hero)
	var inventory_node = find_parent("HeroInventory")
	inventory_node.add_child(hero)
	hero = null


func put_into_slot(new_hero):
	hero = new_hero
	hero.position = Vector2(0, 0)
	var inventory_node = find_parent("HeroInventory")
	inventory_node.remove_child(hero)
	add_child(hero)


func initialize_hero(hero_name):
	if hero == null:
		hero = hero_display_scene.instance()
		add_child(hero)
		hero.set_item(hero_name)
	else:
		hero.set_item(hero_name)



