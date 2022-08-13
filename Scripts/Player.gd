extends KinematicBody2D

var moveSpeed = 80
var velocity = Vector2.ZERO
var friction = 20
var acceleration = 20
var gravity = 10
var jumpHeight = 240
var normalJumpHeight = 100

func _ready():
	SignalManager.connect('playerJump', self, 'jump')

func _physics_process(delta):
	applyGravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	if input.x == 0:
		applyFriction()
		$AnimatedSprite.animation = 'Idle'
	else:
		applyAcceleration(input.x)
		$AnimatedSprite.animation = 'Run'
		if input.x > 0:
			$AnimatedSprite.scale.x = 1
		elif input.x < 0:
			$AnimatedSprite.scale.x = -1
	
	if is_on_floor():
		pass
#		if Input.is_action_just_pressed("up"):
#			velocity.y = -normalJumpHeight
	else:
		$AnimatedSprite.animation = 'Jump'
			
	velocity = move_and_slide(velocity, Vector2.UP)

func jump():
	velocity.y = -jumpHeight

func applyGravity():
	velocity.y += gravity;

func applyFriction():
	velocity.x = move_toward(velocity.x, 0, friction)
	
func applyAcceleration(input):
	velocity.x = move_toward(velocity.x, moveSpeed * input, acceleration)

func death():
	get_tree().reload_current_scene()
