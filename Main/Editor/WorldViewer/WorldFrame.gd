extends ViewportContainer

class_name WorldFrame

const ANIMATION_TIME = 1
const material_positive = preload("Shaders/PositiveShader.tres")
const material_negative = preload("Shaders/NegativeShader.tres")

var frame_value : float setget set_frame_value
var time_state : TimeState
var world_id : int

func initialise(loaded_world:PackedScene, actors:Array) -> void:
	var world:QuantumWorld = loaded_world.instance()
	material = material.duplicate()
	$b.add_child(world)
	world.initialise(rect_size, actors)

func update_state(new_time_state:TimeState, new_world_id:int, world_value:Vector2) -> void:
	time_state = new_time_state
	world_id = new_world_id
	var qubit_count = time_state.get_qubit_count()
	var world_active = world_id in time_state.get_affected_worlds()
	
	$b.get_child(0).update_state(time_state, world_id, world_active)
	$SelectionLeft.color = Color(int(world_active),int(world_active),int(world_active),1)
	$SelectionRight.color = Color(int(world_active),int(world_active),int(world_active),1)
	set_frame_value(world_value.x)
	$Probability.text = str(round(world_value.x*100)/100) + "\n" + str(round(world_value.length_squared()*100)) + "%" + "\n" + str(world_id)


func set_state_preview(preview):
	var world_active:bool = world_id in time_state.get_affected_worlds()
	var world_preview_active : bool
	if preview != null:
		world_preview_active = world_id in time_state.get_affected_worlds_preview(preview)
	else:
		world_preview_active = false
	$b.get_child(0).update_state_preview(world_active, preview, world_preview_active)


func set_frame_value(new_frame_value):
	modulate = Color(1,1,1,(abs(new_frame_value))*0.5 + 0)
	if new_frame_value >= 0:
		set_material(material_positive)
	else:
		set_material(material_negative)
	frame_value = new_frame_value


func adjust_anchor(bounds):
	visible = true
	anchor_left = bounds[0]
	anchor_right = bounds[1]
	anchor_top = bounds[2]
	anchor_bottom = bounds[3]
	margin_left = 1
	margin_right = -1
	margin_top = 1
	margin_bottom = -1


func animate_anchor(bounds, new_frame_value):
	var tween = $Tween
	
#	anchor_left = bounds[0]
#	anchor_right = bounds[1]
#	anchor_top = bounds[2]
#	anchor_bottom = bounds[3]
	
	tween.interpolate_property(self, "anchor_left", anchor_left, bounds[0], ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	tween.interpolate_property(self, "anchor_right", anchor_right, bounds[1], ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	tween.interpolate_property(self, "anchor_top", anchor_top, bounds[2], ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	tween.interpolate_property(self, "anchor_bottom", anchor_bottom, bounds[3], ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)

#	tween.interpolate_property(self, "margin_left", margin_left, 1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
#	tween.interpolate_property(self, "margin_right", margin_right, -1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
#	tween.interpolate_property(self, "margin_top", margin_top, 1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
#	tween.interpolate_property(self, "margin_bottom", margin_bottom, -1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	
	tween.interpolate_property(self, "frame_value", frame_value, new_frame_value, ANIMATION_TIME, tween.TRANS_QUINT, tween.EASE_IN_OUT)
	
	tween.start()
