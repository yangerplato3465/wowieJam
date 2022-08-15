extends Area2D

var triggerTimes = 0

func _physics_process(delta):
	var body = get_overlapping_bodies()
	if body.size() > 0:
		if Dialogic.has_current_dialog_node():
			return
		if triggerTimes == 0:
			triggerTimes += 1
			createDialogue('trigger_remind_jump')
			
func dialogic_signal(name):
	if name == 'jonasRun':
		SignalManager.emit_signal("jonasRun")
		SignalManager.emit_signal("playAudio", 'HorrorJonas')
	elif name == 'unlockJ':
		SignalManager.emit_signal("unlockJ")
	elif name == 'playAudio':
		SignalManager.emit_signal("playAudio", 'HorrorHall')
		

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')
