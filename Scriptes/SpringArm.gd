extends SpringArm

export var mouse_sensitivity = 0.05
export var zoom_speed = 1

var captured = true


func _ready():
	set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		if captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		captured = not captured
	if Input.is_action_just_released("zoom_in"):
		spring_length -= zoom_speed
	if Input.is_action_just_released("zoom_out"):
		spring_length += zoom_speed
#
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 30)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
