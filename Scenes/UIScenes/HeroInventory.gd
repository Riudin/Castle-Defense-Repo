extends Control

onready var inventory_slots = $InventorySlots
onready var equip_slots = $EquipSlots.get_children()

var holding_hero = null


func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		slots[i].slotType = Slot_Class.SlotType.INVENTORY
		
	for i in range(equip_slots.size()):
		equip_slots[i].connect("gui_input", self, "slot_gui_input", [equip_slots[i]])
		equip_slots[i].slot_index = i
		equip_slots[i].slotType = Slot_Class.SlotType.EQUIPPED
	
	initialize_inventory()
	initialize_equips()


func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range (slots.size()):
		if HeroInventoryManager.inventory.has(i):
			slots[i].initialize_hero(HeroInventoryManager.inventory[i][0])


func initialize_equips():
	for i in range (equip_slots.size()):
		if HeroInventoryManager.equips.has(i):
			equip_slots[i].initialize_hero(HeroInventoryManager.equips[i][0])


func slot_gui_input(event: InputEvent, slot: Slot_Class):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_hero != null:
				if !slot.hero:
					left_click_empty_slot(slot)
				else:
					left_click_different_hero(event, slot)
			elif slot.hero:
				left_click_not_holding(slot)


func _input(event):
	if holding_hero:
		holding_hero.global_position = get_global_mouse_position()


func left_click_empty_slot(slot: Slot_Class):
	HeroInventoryManager.add_hero_to_empty_slot(holding_hero, slot)
	slot.put_into_slot(holding_hero)
	holding_hero = null


func left_click_different_hero(event: InputEvent, slot: Slot_Class):
	HeroInventoryManager.remove_hero(slot)
	HeroInventoryManager.add_hero_to_empty_slot(holding_hero, slot)
	var temp_hero = slot.hero
	slot.pick_from_slot()
	temp_hero.global_position = event.global_position
	slot.put_into_slot(holding_hero)
	holding_hero = temp_hero


func left_click_not_holding(slot: Slot_Class):
	HeroInventoryManager.remove_hero(slot)
	holding_hero = slot.hero
	slot.pick_from_slot()
	holding_hero.global_position = get_global_mouse_position()
