extends ActionLibrary
class_name PrayAction

const TEXTURE = "res://Textures/Actions/Pray.png"
const TOOLTIP := "pray"

func _ready():

	var _main_story = str(executer.character_name) + " have prayed"
	var emit_story_telling = emit_story_telling(_main_story)
	
	yield(emit_story_telling, "completed")
	queue_free()
