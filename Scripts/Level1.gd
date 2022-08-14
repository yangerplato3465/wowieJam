extends Node2D


func _ready():
	createDialogue('initial_dialogue')
	
func dialogic_signal(name):
	pass
#	print('here')
#	if name == 'cantMove':
#		SignalManager.emit_signal("cantMove")
#	elif name == 'end':
#		if trigger_1:
#			createDialogue('trigger_1')

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')

