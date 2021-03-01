extends Node

const LEVEL_SELECT_SCENE = preload("Main/LevelSelect/LevelSelect.tscn")
const EDITOR_SCENE = preload("Main/Editor/Editor.tscn")

func _ready():
	_create_level_select_instancce()


func _create_level_select_instancce():
	var level_select_scene_instance = LEVEL_SELECT_SCENE.instance()
	add_child(level_select_scene_instance)
	level_select_scene_instance.connect("level_selected", self, "on_level_select")

func _create_editor_instance(level_scene:PackedScene) -> void:
	var editor_instance = level_scene.instance()
	add_child(editor_instance)
	editor_instance.get_child(0).initialise()
	editor_instance.get_child(0).connect("return_to_level_select", self, "on_return_to_level_select")


func on_level_select(level_path):
	_create_editor_instance(level_path)
	remove_child($LevelSelect)

func on_return_to_level_select():
	_create_level_select_instancce()
	remove_child(get_child(0))
	
func _unhandled_input(event):
	if event.is_action("quit"):
		get_tree().quit()
	if event.is_action("toggle_fullscreen"):
		if event.is_pressed():
			OS.window_fullscreen = !OS.window_fullscreen
