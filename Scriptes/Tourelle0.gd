extends Spatial

# recharger
var timerRecharge = Timer.new()
var tirePret = true
var tempsRecharge = 1

# bullet
onready var bullet = preload("res://Scenes/Bullet.tscn")
# ennemis à porté
var ennemis = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# initialisation du timer
	timerRecharge.one_shot = true
	timerRecharge.connect("timeout",self,"finRecharge")
	add_child(timerRecharge)
	CommencerRechage()

func _process(delta):
	if tirePret and not ennemis.empty():
		tirer()

func finRecharge():
	tirePret = true

func CommencerRechage():
	timerRecharge.start(tempsRecharge)

func tirer():
	print("TIRE !")
	# choix de l'ennemi
	var ennemi = ennemis[0]
	# tire sur un ennemi
	var b = bullet.instance()
	$canon.add_child(b)
	b.look_at(ennemi.transform.origin, Vector3.UP)
	b.shoot = true
	# ennemi.on_hit(4)
	# 
	tirePret = false
	CommencerRechage()
	

func _on_zoneDetection_body_entered(body):
	if body.is_in_group("Ennemis"):
		ennemis.append(body)

func _on_zoneDetection_body_exited(body):
	ennemis.erase(body)
