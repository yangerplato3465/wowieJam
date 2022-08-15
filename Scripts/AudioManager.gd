extends Node2D


func play(name = null):
	stopAll()
	if name:
		get_node(name).play()


func stopAll():
	$HorrorHall.stop()
	$Normal.stop()
	$GoodEnd.stop()
	$HorrorJonas.stop()
