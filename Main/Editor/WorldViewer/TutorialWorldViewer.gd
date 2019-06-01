extends Control

var CODE_BLOCKS := CodeBlocks.CodeBlockID

func initialise_world_viewer(time_state:TimeState, world_path):
	set_picture(time_state)

func apply_matrix(new_time_state:TimeState, change_matrix:SparseMatrix) -> void:
	set_picture(new_time_state)

func set_state(time_state:TimeState):
	set_picture(time_state)

func update_previews(preview=null):
	pass

func set_picture(time_state:TimeState) -> void:
	var time := time_state.get_time()
	if time == 0:
		$A.show(); $B.hide(); $C.hide();
	elif time % 2 == 1:
		$A.hide(); $B.show(); $C.hide();
	else:
		$A.hide(); $B.hide(); $C.show();