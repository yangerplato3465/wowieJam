extends Area2D

var triggerTimes = 0

func _physics_process(delta):
	var body = get_overlapping_bodies()
	if body.size() > 0:
		if Dialogic.has_current_dialog_node():
			return
		if triggerTimes == 0:
			triggerTimes += 1
			createDialogue('trigger_warn_pit_1')
			SignalManager.emit_signal('cantMove')
		elif triggerTimes >= 1:
			triggerTimes += 1
			createDialogue('trigger_warn_pit_2')
			
func dialogic_signal(name):
	if name == 'canMove':
		SignalManager.emit_signal("canMove")
	elif name == 'jump':
		SignalManager.emit_signal("playerJump")
		
func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')
