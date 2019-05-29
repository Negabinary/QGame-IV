extends PanelContainer

const CODE_BLOCK_TEXTURES = preload("res://CodeBlocks/CodeBlocks.gd").CODE_BLOCK_TEXTURES
const WORLD_CHARACTERS = preload("res://Actors/WorldCharacters.gd")
const CODE_BLOCK_MOUSE_POINTER = preload("res://CodingUI/CodeBlockMouseFollower.tscn")

var actor
var actor_id
var code_block = CodeBlocks.new_code_block()



func _ready():
	connect("mouse_exited", self, "on_mouse_exited")

func initialise(actor, actor_id):
	self.actor = actor
	self.actor_id = actor_id


func remove_block() -> void:
	$Sprite.texture = null
	self.code_block = CodeBlocks.new_code_block()
	_signal_block_removed()

func change_block(code_block):
	$Sprite.texture = load(CODE_BLOCK_TEXTURES[code_block.code_block_id])
	self.code_block = code_block
	_signal_block_changed()

func add_block(code_block:CodeBlock) -> void:
	$Sprite.texture = load(CODE_BLOCK_TEXTURES[code_block.code_block_id])
	self.code_block = code_block
	code_block.set_actor(actor_id, actor)
	_signal_block_added()

func preview_block(code_block):
	_signal_block_preview(code_block)

func end_preview_block():
	_signal_block_preview_end()

func get_code_block():
	return code_block


signal block_added
signal block_changed
signal block_removed
signal block_preview
signal block_preview_end


func drop_data(position, data):
	if data.drag_type == "code_block":
		mouse_default_cursor_shape = CURSOR_POINTING_HAND
		add_block(data.code_block)

func get_drag_data(position):
	if code_block != null:
		var drag_data = {"drag_type":"code_block", "code_block":code_block}
		mouse_default_cursor_shape = CURSOR_ARROW
		set_drag_preview(_make_drag_preview(code_block))
		remove_block()
		return drag_data

func _make_drag_preview(code_block):
	var drag_preview = CODE_BLOCK_MOUSE_POINTER.instance()
	drag_preview.set_drag(code_block.code_block_id)
	return drag_preview

func can_drop_data(position, data):
	var can_drop_data = data.drag_type == "code_block" and (data.code_block.code_block_id in WORLD_CHARACTERS.ACCEPTS[actor.type])
	if can_drop_data:
		var global_rect = get_global_rect()
		data.code_block.set_actor(actor_id, actor)
		preview_block(data.code_block)
	return can_drop_data

func on_mouse_exited():
	end_preview_block()


func _signal_block_added():
	emit_signal("block_added", actor_id, code_block)

func _signal_block_changed():
	emit_signal("block_changed", actor_id, code_block)

func _signal_block_removed():
	emit_signal("block_removed", actor_id)

func _signal_block_preview(code_block):
	emit_signal("block_preview", actor_id, code_block)

func _signal_block_preview_end():
	emit_signal("block_preview_end", actor_id)

