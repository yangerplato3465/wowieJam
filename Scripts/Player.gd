extends KinematicBody2D

var moveSpeed = 80
var velocity = Vector2.ZERO
var friction = 20
var acceleration = 20
var gravity = 10
var jumpHeight = 240
var normalJumpHeight = 100
var canMove = true
var canJJump = false

func _ready():
	SignalManager.connect('playerJump', self, 'jump')
	SignalManager.connect('usePC', self, 'usePC')
	SignalManager.connect('canMove', self, 'canMove')
	SignalManager.connect('cantMove', self, 'cantMove')
	SignalManager.connect('unlockJ', self, 'unlockJ')

func _physics_process(delta):
	if !canMove:
		return
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
		if Input.is_action_just_pressed("jump"):
			jump()
			if !canJJump:
				forceDialogue('early_jump')
	else:
		$AnimatedSprite.animation = 'Jump'
			
	velocity = move_and_slide(velocity, Vector2.UP)

func forceDialogue(timeline):
	if Dialogic.has_current_dialog_node():
		if Dialogic.get_current_timeline() != 'early_jump':
			Dialogic.change_timeline(timeline)
	else:
		var dialog = Dialogic.start(timeline)
		add_child(dialog)
		dialog.connect('dialogic_signal', self, 'dialogic_signal')

func dialogic_signal(name):
	print("here")
	if name == 'cantMove':
		cantMove()

func usePC():
	canMove = false;
	$AnimatedSprite.animation = 'usePC'

func canMove():
	canMove = true

func cantMove():
	canMove = false

func jump():
	$AudioStreamPlayer.play()
	velocity.y = -jumpHeight

func applyGravity():
	velocity.y += gravity;

func applyFriction():
	velocity.x = move_toward(velocity.x, 0, friction)
	
func applyAcceleration(input):
	velocity.x = move_toward(velocity.x, moveSpeed * input, acceleration)

func unlockJ():
	canJJump = true

func death():
	get_tree().change_scene("res://Scene/bad_ending_die_to_jonas.tscn")


func _on_Area2D_body_entered(body):
	if body.name == 'Jonas':
		death()
