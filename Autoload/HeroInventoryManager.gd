extends Node


const NUM_INVENTORY_SLOTS = 30
#const NUM_EQUIP_SLOTS = 4

var inventory = {
	0: ["Fairy"]
}

var equips = {
	
}


func add_hero(hero_name):
#	for hero in inventory:
#		if inventory[hero][0] == hero_name:
#		check if hero is already there and increase size/level
#	
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [hero_name]
			return


func add_hero_to_empty_slot(hero: Hero_Display_Class, slot: Slot_Class):
	match slot.slotType:
		Slot_Class.SlotType.INVENTORY:
			inventory[slot.slot_index] = [hero.hero_name]
		Slot_Class.SlotType.EQUIPPED:
			equips[slot.slot_index] = [hero.hero_name]


func remove_hero(slot: Slot_Class):
	match slot.slotType:
		Slot_Class.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
		Slot_Class.SlotType.EQUIPPED:
			equips.erase(slot.slot_index)
