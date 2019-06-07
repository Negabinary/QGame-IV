extends PanelContainer

const CODE_BLOCK_TEXTURES = CodeBlocks.CODE_BLOCK_TEXTURES
const CODE_BLOCK_MOUSE_POINTER = preload("CodeBlockMouseFollower.tscn")

var actor : Actor
var code_block := CodeBlocks.new_code_block()


func _ready():
	connect("mouse_exited", self, "on_mouse_exited")

func initialise(actor:Actor) -> void:
	self.actor = actor


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
	code_block.set_actor(actor)
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
	if not code_block is CodeBlocks.CodeBlockNull:
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
	var can_drop_data = data.drag_type == "code_block" and actor.can_place_code_block(data.code_block)
	if can_drop_data:
		var global_rect = get_global_rect()
		data.code_block.set_actor(actor)
		preview_block(data.code_block)
	return can_drop_data

func on_mouse_exited():
	end_preview_block()


func _signal_block_added():
	var actor_id = actor.get_actor_id()
	emit_signal("block_added", actor_id, code_block)

func _signal_block_changed():
	var actor_id = actor.get_actor_id()
	emit_signal("block_changed", actor_id, code_block)

func _signal_block_removed():
	var actor_id = actor.get_actor_id()
	emit_signal("block_removed", actor_id)

func _signal_block_preview(code_block):
	var actor_id = actor.get_actor_id()
	emit_signal("block_preview", actor_id, code_block)

func _signal_block_preview_end():
	var actor_id = actor.get_actor_id()
	emit_signal("block_preview_end", actor_id)

