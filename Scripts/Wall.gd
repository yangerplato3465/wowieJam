extends StaticBody2D

var triggerTimes = 0

func _ready():
	SignalManager.connect('openWall', self, 'openWall')

func dialogic_signal(name):
	pass

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')

func _on_Area2D_body_entered(body):
	if Dialogic.has_current_dialog_node():
		return
	if body.name == "Player":
		triggerTimes += 1
		if triggerTimes < 5 || triggerTimes > 5:
			createDialogue('trigger_hit_wall_1')
		elif triggerTimes == 5:
			createDialogue('trigger_hit_wall_2')
		

func openWall():
	queue_free()
