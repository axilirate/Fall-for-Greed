extends Node

onready var game_screen = get_tree().get_root().get_node("GameScreen")
onready var character_labels = game_screen.get_node("CharacterLabels")

var path_dictionary = PathDictionary.new()
var directory = Directory.new()


func character_object_from_name(_name):
	_name = _name.replace(" ", "")
	var path = path_dictionary.CHARACTERS_PATH + _name +".gd"
	if directory.file_exists(path):
		return load(path).new()
	else:
		return null


func _ready():
	update_characters()
	if not directory.file_exists(PathDictionary.SAVE_PATH):
		summon_character(PyryWright.new())
		
	
	


func update_characters():
	for old_character in get_children():
		old_character.free()
	
	for _character_label in character_labels.get_children():
		_character_label.visible = false
		
	var _characters = Save.get_section_values("characters")
	if _characters:
		for _character_name in _characters:
			var _character = dict2inst(Save.get_saved_value("characters", _character_name))
			add_child(_character)
			connect_character_signals(_character)
			update_character_label(_character)
		



func summon_character(_character_type: Object):
	
	var _character = Character.new()
	_character.current_character = _character_type
	randomize()
	_character.stats["health"] = rand_range(0.5,1)
	_character.stats["hunger"] = rand_range(0.5,1)
	_character.stats["energy"] = rand_range(0.5,1)
	_character.stats["loneliness"] = rand_range(0.5,1)
	
	_character.hormones["melatonin"] = rand_range(0.0,0.024)
	
	
	if _character_type.get("ARMOR"):
		_character.stats["armor"] = _character_type.ARMOR
		
	if _character_type.get("FOCUS"):
		_character.traits["focus"] = _character_type.FOCUS
	if _character_type.get("HUMOR"):
		_character.traits["humor"] = _character_type.HUMOR
	if _character_type.get("COMBAT"):
		_character.traits["combat"] = _character_type.COMBAT
		
		
		
	if _character_type.get("STARTING_ITEMS"):
		for _item in _character_type.STARTING_ITEMS:
			if rand_range(0,1) < 0.1:
				_character.inventory.append(_item.new())
				
	add_child(_character)
	connect_character_signals(_character)
	update_character_label(_character)
	


func update_character_label(_character: Character):
	for _character_label in character_labels.get_children():
		if not _character_label.visible:
			_character_label.text = _character.character_name
			_character_label.connect("character_selected", _character, "_on_character_selected")
			_character_label.self_profile_texture = _character.self_profile_picture
			_character_label.story = _character.story
			_character_label.character = _character
			_character_label.visible = true
			break





func connect_character_signals(character: Character):
#	Connect Actions
	var west_action = game_screen.get_node("Actions/WestAction")
# warning-ignore:return_value_discarded
	character.connect("update_west_action", west_action, "_on_update_west_action")
	
	var left_action = game_screen.get_node("Actions/LeftAction")
# warning-ignore:return_value_discarded
	character.connect("update_left_action", left_action, "_on_update_left_action")
	
	var right_action = game_screen.get_node("Actions/RightAction")
# warning-ignore:return_value_discarded
	character.connect("update_right_action", right_action, "_on_update_right_action")
	
	var east_action = game_screen.get_node("Actions/EastAction")
# warning-ignore:return_value_discarded
	character.connect("update_east_action", east_action, "_on_update_east_action")
	
	
#	Connect Inventory Slots
	var north_west_slot = game_screen.get_node("Inventory/NorthWestSlot")
# warning-ignore:return_value_discarded
	character.connect("update_north_west_slot", north_west_slot, "_on_slot_update")
	
	var north_slot = game_screen.get_node("Inventory/NorthSlot")
# warning-ignore:return_value_discarded
	character.connect("update_north_slot", north_slot, "_on_slot_update")
	
	var north_east_slot = game_screen.get_node("Inventory/NorthEastSlot")
# warning-ignore:return_value_discarded
	character.connect("update_north_east_slot", north_east_slot, "_on_slot_update")
	
	var west_slot = game_screen.get_node("Inventory/WestSlot")
# warning-ignore:return_value_discarded
	character.connect("update_west_slot", west_slot, "_on_slot_update")
	
	var center_slot = game_screen.get_node("Inventory/CenterSlot")
# warning-ignore:return_value_discarded
	character.connect("update_center_slot", center_slot, "_on_slot_update")
	
	var east_slot = game_screen.get_node("Inventory/EastSlot")
# warning-ignore:return_value_discarded
	character.connect("update_east_slot", east_slot, "_on_slot_update")
	
	var south_slot = game_screen.get_node("Inventory/SouthSlot")
# warning-ignore:return_value_discarded
	character.connect("update_south_slot", south_slot, "_on_slot_update")
	
	var south_east_slot = game_screen.get_node("Inventory/SouthEastSlot")
# warning-ignore:return_value_discarded
	character.connect("update_south_east_slot", south_east_slot, "_on_slot_update")
	
	
	
	
	
