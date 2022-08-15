extends Area2D

var triggerTimes = 0
export(bool) var isLast = false

func _physics_process(delta):
	var body = get_overlapping_bodies()
	if body.size() > 0:
		if Dialogic.has_current_dialog_node():
			return
		if Input.is_action_just_pressed("ui_accept"):
			if !isLast:
				if triggerTimes == 0:
					triggerTimes += 1
					createDialogue("computer_1")
					SignalManager.emit_signal("usePC")
				elif triggerTimes == 1:
					triggerTimes += 1
					createDialogue("computer_2")
					SignalManager.emit_signal("usePC")
			elif isLast:
				createDialogue("computer_3")
				SignalManager.emit_signal("usePC")
			
func dialogic_signal(name):
	if name == 'canMove':
		SignalManager.emit_signal("canMove")
	elif name == 'openWall':
		SignalManager.emit_signal("openWall")
	elif name == 'playAudio':
		SignalManager.emit_signal('playAudio', 'HorrorJonas')

func createDialogue(timeline):
	var dialog = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, 'dialogic_signal')
