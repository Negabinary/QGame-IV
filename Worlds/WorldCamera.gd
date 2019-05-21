extends Camera2D


var viewport_size
export (Vector2) var scene_size = Vector2(0, 0)

func initialise():
	_process(10)


func _process(delta):
	if viewport_size != get_viewport_rect().size:
		viewport_size = get_viewport_rect().size
		var wscale = viewport_size.x / scene_size.x
		var hscale = viewport_size.y / scene_size.y
		var minscale = max(min(wscale,hscale),0.001)
		zoom = Vector2(1/minscale, 1/minscale)
		var view_size = viewport_size / minscale
		transform.origin.x = -(view_size.x / 2)
		transform.origin.y = -(view_size.y / 2)