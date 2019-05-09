extends PanelContainer

const CODE_BLOCK_TEXTURES = preload("res://Enums/CodeBlocks.gd").CODE_BLOCK_TEXTURES
const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd")
const CODE_BLOCK_MOUSE_POINTER = preload("res://CodingUI/CodeBlockMouseFollower.tscn")

var _actor
var _actor_id
var _code_block = null



func _ready():
	connect("mouse_exited", self, "on_mouse_exited")

func initialise(actor, actor_id):
	_actor = actor
	_actor_id = actor_id


func remove_block():
	$Sprite.texture = null
	self._code_block = null
	_signal_block_removed()

func change_block(code_block):
	$Sprite.texture = load(CODE_BLOCK_TEXTURES[code_block])
	self._code_block = code_block
	_signal_block_changed()

func add_block(code_block):
	$Sprite.texture = load(CODE_BLOCK_TEXTURES[code_block])
	self._code_block = code_block
	_signal_block_added()

func preview_block(code_block):
	_signal_block_preview(code_block)

func end_preview_block():
	_signal_block_preview_end()

func get_code_block():
	return _code_block


signal block_added
signal block_changed
signal block_removed
signal block_preview
signal block_preview_end


func drop_data(position, data):
	if data.drag_type == "code_block":
		mouse_default_cursor_shape = CURSOR_POINTING_HAND
		if _code_block == null:
			add_block(data.code_block)
		elif _code_block == data.code_block:
			pass
		else:
			change_block(data.code_block)

func get_drag_data(position):
	if _code_block != null:
		var drag_data = {"drag_type":"code_block", "code_block":_code_block}
		mouse_default_cursor_shape = CURSOR_ARROW
		set_drag_preview(_make_drag_preview(_code_block))
		remove_block()
		return drag_data

func _make_drag_preview(code_block):
	var drag_preview = CODE_BLOCK_MOUSE_POINTER.instance()
	drag_preview.set_drag(code_block)
	return drag_preview

func can_drop_data(position, data):
	var can_drop_data = data.drag_type == "code_block" and (data.code_block in WORLD_CHARACTERS.ACCEPTS[_actor.type])
	if can_drop_data:
		var global_rect = get_global_rect()
		preview_block(data.code_block)
	return can_drop_data

func on_mouse_exited():
	end_preview_block()


func _signal_block_added():
	emit_signal("block_added", _actor_id, _code_block)

func _signal_block_changed():
	emit_signal("block_changed", _actor_id, _code_block)

func _signal_block_removed():
	emit_signal("block_removed", _actor_id)

func _signal_block_preview(code_block):
	emit_signal("block_preview", _actor_id, code_block)

func _signal_block_preview_end():
	emit_signal("block_preview_end", _actor_id)

