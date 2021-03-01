extends Control

var CODE_BLOCKS := CodeBlocks.CodeBlockID
var actors:Array

func initialise_world_viewer(time_state:TimeState, world_path:String, actors:Array) -> void:
	set_picture(time_state)
	self.actors = actors

func apply_matrix(new_time_state:TimeState, change_matrix:SparseMatrix) -> void:
	set_picture(new_time_state)

func set_state(time_state:TimeState):
	set_picture(time_state)

func update_previews(preview=null):
	pass

func set_picture(time_state:TimeState) -> void:
	var time := time_state.get_time()
	if time % 2 == 0:
		$A.show(); $B.hide()
	else:
		$B.show(); $A.hide()
	
	while $C.get_child_count() < floor(time / 2):
		var d = $D.duplicate()
		$C.add_child(d)
		d.rect_position = Vector2(randf() * ($C.rect_size.x - d.rect_size.x), 0)
		d.show()
