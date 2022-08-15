extends Node2D



func _ready():
	SignalManager.connect('playAudio', self, 'playAudio')
	createDialogue('initial_dialogue')
	$AudioManager.play('Normal')
	
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

func playAudio(name):
	$AudioManager.play(name)

