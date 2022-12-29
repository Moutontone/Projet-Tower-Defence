extends Spatial

# recharger
var timerRecharge = Timer.new()
var tirePret = true
var tempsRecharge = 1

# bullet
onready var bullet = preload("res://Projectiles/Bullet.tscn")

# ennemis à porté
var ennemis = []
var cible

onready var pivot = $pivot
onready var canon = $pivot/canon

func _ready():
	# initialisation du timer
	timerRecharge.one_shot = true
	timerRecharge.connect("timeout",self,"finRecharge")
	add_child(timerRecharge)
	CommencerRechage()

func _physics_process(delta):
	# choix cible
	if not ennemis.empty():
		cible = ennemis[0]
	else: 
		cible = null
	# tourner le cannon
	turnFlat()
	# tirer
	if tirePret and not ennemis.empty():
		tirer()

func turnFlat():
	if cible != null:
		pivot.look_at(cible.global_transform.origin, Vector3.UP)
		#var target = self.global_transform.origin - cible.global_transform.origin
		#pivot.rotation.y = lerp_angle(pivot.rotation.y, atan2( target.x, target.z ), 1 )

func CommencerRechage():
	timerRecharge.start(tempsRecharge)

func finRecharge():
	tirePret = true

func tirer():
	# tire sur un ennemi
	var b = bullet.instance()
	canon.add_child(b)
	b.look_at(cible.global_transform.origin, Vector3.UP)
	b.shoot = true
	tirePret = false
	CommencerRechage()

func _on_Zone_detection_body_entered(body):
	if body.is_in_group("Ennemis"):
		ennemis.append(body)


func _on_Zone_detection_body_exited(body):
	ennemis.erase(body)
