extends Spatial

# recharger
var timerRecharge = Timer.new()
var tirePret = false
var tempsRecharge = 1

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
	ennemi.on_hit(4)
	# 
	tirePret = false
	CommencerRechage()
	

func _on_zoneDetection_body_entered(body):
	var node = body.get_parent()
	if node.is_in_group("Ennemis"):
		ennemis.append(node)

func _on_zoneDetection_body_exited(body):
	var node = body.get_parent()
	ennemis.erase(node)
