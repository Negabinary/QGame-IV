extends Control

func set_drag(new_id:int):
	visible = true
	get_children()[new_id].visible = true


func snap_to(position):
	rect_position = position


"""
func _ready():
	visible = false


func _process(delta):
	if snap_pos:
		transform.origin = snap_pos
	else:
		transform.origin = get_global_mouse_position() + Vector2(-25,-25)


# DropArea.gd


# DropArea.gd
func release_snap():
	snap_pos = null
"""