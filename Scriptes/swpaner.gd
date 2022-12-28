extends Spatial

var path
var path_follow
var ennemi

var timerInvocation = Timer.new()
var delaisInvocation = 2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	path = get_parent()
	path_follow = load("res://Scenes/PathFollowEnnemi0.tscn")
	ennemi = load("res://Scenes/Ennemi0.tscn")

	
	timerInvocation.connect("timeout",self,"invocation")
	add_child(timerInvocation)
	timerInvocation.start(delaisInvocation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func invocation():
	var pathfollow = path_follow.instance()
	pathfollow.add_child(ennemi.instance())
	path.add_child(pathfollow)
