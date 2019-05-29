extends TextureButton

class_name CodeShelfBlock

const CODE_BLOCKS = preload("res://CodeBlocks/CodeBlocks.gd").CodeBlockID
const CODE_BLOCK_MOUSE_POINTER = preload("res://CodingUI/CodeBlockMouseFollower.tscn")

export (CODE_BLOCKS) var dragging_id


func _ready():
	mouse_default_cursor_shape = CURSOR_POINTING_HAND


func get_drag_data(position):
	set_drag_preview(_make_drag_preview())
	var code_block = CodeBlocks.new_code_block(dragging_id)
	return {"drag_type":"code_block", "code_block":code_block}


func _make_drag_preview():
	var drag_preview = CODE_BLOCK_MOUSE_POINTER.instance()
	drag_preview.set_drag(dragging_id)
	return drag_preview