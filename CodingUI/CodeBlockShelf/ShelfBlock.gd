extends TextureButton
const CODE_BLOCKS = preload("res://Enums/CodeBlocks.gd").CodeBlocks
const CODE_BLOCK_MOUSE_POINTER = preload("res://CodingUI/CodeBlockMouseFollower.tscn")

export (CODE_BLOCKS) var dragging_id


func _ready():
	mouse_default_cursor_shape = CURSOR_POINTING_HAND


func get_drag_data(position):
	set_drag_preview(_make_drag_preview())
	return {"drag_type":"code_block", "code_block":dragging_id}


func _make_drag_preview():
	var drag_preview = CODE_BLOCK_MOUSE_POINTER.instance()
	drag_preview.set_drag(dragging_id)
	return drag_preview