extends Node

const CODE_BLOCKS = preload("res://Enums/CodeBlocks.gd").CodeBlocks

onready var characters = $Characters.get_children()


func initialise():
	$Camera2D.initialise()


func update_state(new_state, code_array, active, preview, preview_active):
	for i in range(new_state.size()):
		if new_state[i] == 1:
			characters[i].get_node("Off").visible = false
			characters[i].get_node("OffSword").visible = false
			if code_array[i] == CODE_BLOCKS.SWORD and active:
				characters[i].get_node("On").visible = false
				characters[i].get_node("OnSword").visible = true
			else:
				characters[i].get_node("On").visible = true
				characters[i].get_node("OnSword").visible = false
		if new_state[i] == 0:
			characters[i].get_node("On").visible = false
			characters[i].get_node("OnSword").visible = false
			if code_array[i] == CODE_BLOCKS.SWORD and active:
				characters[i].get_node("Off").visible = false
				characters[i].get_node("OffSword").visible = true
			else:
				characters[i].get_node("Off").visible = true
				characters[i].get_node("OffSword").visible = false
		
		if preview == null:
			characters[i].modulate = Color(1,1,1,1)
		else:
			if preview.get_qubit_id() == i and active and preview_active:
				characters[i].modulate = Color(1,0,0,1)
			else:
				characters[i].modulate = Color(1,1,1,1)

func update_state_preview(active, preview, preview_active):
	for i in range(characters.size()):
		if preview == null:
			characters[i].modulate = Color(1,1,1,1)
		else:
			if preview.get_qubit_id() == i and active and preview_active:
				characters[i].modulate = Color(1,0,0,1)
			else:
				characters[i].modulate = Color(1,1,1,1)