extends Node
class_name QuantumWorld

onready var characters = $Characters.get_children()
var actors : Array

func initialise(viewport_size, actors:Array):
	self.actors = actors
	$Camera2D.initialise(viewport_size)


func update_state(time_state:TimeState, world_id:int, active:bool) -> void:
	for actor in actors:
		var active_sprites:Array = time_state.get_actor_sprites(actor, world_id, active)
		var character_id:int = actor.get_actor_id() #characters.size() - actor.get_actor_id() - 1 #
		var character:Node = $Characters.get_child(character_id)
		for sprite in character.get_children():
			if sprite.get_name() in active_sprites:
				sprite.visible = true
			else:
				sprite.visible = false
		character.modulate = Color(1,1,1,1)

func update_state_preview(active, preview, preview_active):
	for i in range(characters.size()):
		if preview == null:
			characters[i].modulate = Color(1,1,1,1)
		else:
			if preview.get_actor_id() == i and active and preview_active:
				characters[i].modulate = Color(1,0,0,1)
			else:
				characters[i].modulate = Color(1,1,1,1)
