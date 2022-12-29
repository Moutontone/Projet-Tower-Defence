extends KinematicBody

export (float) var speed = 10
export (float) var jump_strength = 20
export (float) var gravity = 50

export (NodePath) var c = self

export (float) var mouse_sensitivity = 0.03

var _snap_vector = Vector3.DOWN
var _velocity = Vector3.ZERO
var turret = load("res://Scenes/Tourelle0.tscn")
onready var _spring_arm = $SpringArm
onready var _model = $Pivot

onready var camera = $Camroot/h/v/ClippedCamera


func _physics_process(delta):
	var move_direction = Vector3.ZERO
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed = is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping = is_on_floor() and Input.is_action_just_pressed("jump")
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	
	if _velocity.length() > 0.2:
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()



func _process(_delta):
	_spring_arm.translation = translation
	if Input.is_action_just_pressed("built"):
		built()

func built():
	if is_on_floor():
		var t = turret.instance()
		t.transform = global_transform
		get_parent().add_child(t)

	
	
