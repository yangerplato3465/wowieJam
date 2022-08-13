extends Area2D

var triggerTimes = 0

func _physics_process(delta):
	var body = get_overlapping_bodies()
	if body.size() > 0:
		if Dialogic.has_current_dialog_node():
			return
		if triggerTimes == 0:
			triggerTimes += 1
			createDialogue('trigger_first_jump_1')
		elif triggerTimes == 1:
			triggerTimes += 1
			createDialogue('trigger_first_jump_2')
		elif triggerTimes == 2:
			triggerTimes += 1
			createDialogue('trigger_first_jump_3')
		elif triggerTimes == 3:
			triggerTimes += 1
			createDialogue('trigger_first_jump_4')
		elif triggerTimes == 4:
			triggerTimes += 1
			createDialogue('trigger_first_jump_5')
		elif triggerTimes == 5:
			triggerTimes += 1
			createDialogue('trigger_first_jump_6')
		

#func _on_trigger_1_body_entered(body):
#	if Dialogic.has_current_dialog_node():
#		return
#	if body.name == "Player":
#		if triggerTimes == 0:
#			triggerTimes += 1
#			createDialogue('trigger_first_jump_1')
#		elif triggerTimes == 1:
#			triggerTimes += 1
#			createDialogue('trigger_first_jump_2')
#		elif triggerTimes == 2:
#			triggerTimes += 1
#			createDialogue('trigger_first_jump_3')
#		elif triggerTimes == 3:
#			triggerTimes += 1
#			createDialogue('trigger_first_jump_4')
			
func dialogic_signal(name):
	if name == 'jump':
		SignalManager.emit_signal("playerJump")

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')
