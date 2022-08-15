extends Node2D


func _ready():
	$ColorRect/Sprite.modulate.a = 0
	$ColorRect/Sprite/AnimationPlayer.play("fadeIn")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scene/Menu.tscn")
