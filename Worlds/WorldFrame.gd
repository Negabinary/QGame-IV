extends ViewportContainer

class_name WorldFrame

const ANIMATION_TIME = 1
onready var material_positive = load("res://Worlds/Shaders/PositiveShader.tres")
onready var material_negative = load("res://Worlds/Shaders/NegativeShader.tres")

var frame_value : float setget set_frame_value
var time_state : TimeState
var world_id : int

func initialise(loaded_world):
	var world = loaded_world.instance()
	material = material.duplicate()
	$b.add_child(world)
	world.initialise(rect_size)

func update_state(new_time_state, new_world_id, max_state, preview, world_value:Vector2):
	time_state = new_time_state
	world_id = new_world_id
	var qubit_count = time_state.get_qubit_count()
	var world_state_array = _get_world_state_array(world_id, qubit_count)
	var code_array = time_state.get_qubit_code_block_array()
	var world_active = world_id in time_state.get_affected_worlds()
	
	var world_preview_active
	if preview != null:
		world_preview_active = world_id in time_state.get_affected_worlds_preview(preview)
	else:
		world_preview_active = false
	
	$b.get_child(0).update_state(world_state_array, code_array, world_active, preview, world_preview_active)
	$SelectionLeft.color = Color(int(world_active),int(world_active),int(world_active),1)
	$SelectionRight.color = Color(int(world_active),int(world_active),int(world_active),1)
	#$ColorRect.color = Color(0,0,0,1-(world_value.length_squared()/max_state))
	set_frame_value(world_value.x)
	$Probability.text = str(round(world_value.x*100)/100) + "\n" + str(round(world_value.length_squared()*100)) + "%" + "\n" + str(rect_size.x) + ", " + str(rect_size.y)

func set_state_preview(preview):
	var world_active = world_id in time_state.get_affected_worlds()
	var world_preview_active
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
	
	anchor_left = bounds[0]
	anchor_right = bounds[1]
	anchor_top = bounds[2]
	anchor_bottom = bounds[3]

	tween.interpolate_property(self, "margin_left", margin_left, 1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	tween.interpolate_property(self, "margin_right", margin_right, -1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	tween.interpolate_property(self, "margin_top", margin_top, 1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	tween.interpolate_property(self, "margin_bottom", margin_bottom, -1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	
	tween.interpolate_property(self, "margin_bottom", margin_bottom, -1, ANIMATION_TIME, tween.TRANS_QUINT , tween.EASE_IN_OUT)
	
	tween.interpolate_property(self, "frame_value", frame_value, new_frame_value, ANIMATION_TIME, tween.TRANS_QUINT, tween.EASE_IN_OUT)
	
	tween.start()


func _get_world_state_array(world_id, qubit_count):
	var world_state_array = []
	for i in range(qubit_count):
		world_state_array += [world_id % 2]
		world_id = world_id >> 1
	return world_state_array

