extends Area2D


var canBack = false
var triggered = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") && canBack:
		get_tree().change_scene("res://Scene/Menu.tscn")


func _on_trigger_good_end_body_entered(body):
	if body.name == 'Player' && !triggered:
		triggered = true
		$AnimationPlayer.play("fadeWord")
		canBack = true
