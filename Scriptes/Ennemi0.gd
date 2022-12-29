extends Spatial


var pv = 10
var maxpv = 10

onready var health = $Health
onready var healthBar = $HeathBar3D/Viewport/HealthBar

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# health connexion
	health.connect("changed", healthBar, "set_value")
	health.connect("max_changed", healthBar, "set_max")
	health.initialize()

func on_hit(degat):
	# kill path follow
	health.current -= degat 
	if health.current <= 0:
		get_parent().queue_free()
		self.queue_free()
