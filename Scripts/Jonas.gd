extends KinematicBody2D

var canMove = false;
var velocity = Vector2.ZERO

func _ready():
	SignalManager.connect("jonasRun", self, "jonasRun")
	pass
	
func _physics_process(delta):
	if !canMove: 
		return
	velocity.x = 50
	velocity = move_and_slide(velocity, Vector2.UP)

func jonasRun():
	canMove = true
