extends Area2D

var triggerTimes = 0

func _physics_process(delta):
	var body = get_overlapping_bodies()
	if body.size() > 0:
		if Dialogic.has_current_dialog_node():
			return
		if triggerTimes == 0:
			triggerTimes += 1
			createDialogue('trigger_dont_go_left_1')
		elif triggerTimes == 1:
			triggerTimes += 1
			createDialogue('trigger_dont_go_left_2')
		elif triggerTimes >= 2:
			createDialogue('trigger_dont_go_left_3')

			
func dialogic_signal(name):
	pass

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')
