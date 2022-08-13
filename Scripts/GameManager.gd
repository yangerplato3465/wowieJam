extends Node2D


func _ready():
	createDialogue('initial_dialogue')
	
func dialogic_signal(name):
	pass
#	if name == 'jump':
#		SignalManager.emit_signal("playerJump")
#	elif name == 'end':
#		if trigger_1:
#			createDialogue('trigger_1')

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')

