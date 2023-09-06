extends Node2D

var note = preload("res://note.tscn")
var child_count = 0


func load_midi():
	var file = FileAccess.open("res://Vampire_Killer_1.mid", FileAccess.READ)
	
	#MIDI File Header
	var MThd = file.get_buffer(4)
	print(MThd.get_string_from_utf8())
	var header_length = file.get_buffer(4)
	header_length.reverse()
	print("Header length: %d" % header_length.decode_u32(0))
	var track_format = file.get_buffer(2)
	track_format.reverse()
	print("Track format: %d" % track_format.decode_u16(0))
	var number_tracks = file.get_buffer(2)
	number_tracks.reverse()
	print("Number of tracks: %d" % number_tracks.decode_u16(0))
	var division = file.get_buffer(2)
	division.reverse()
	print("Division: %d" % division.decode_u16(0))
	
	#Read track data
	var MTrk = file.get_buffer(4)
	print(MTrk.get_string_from_utf8())
	
	
	return 0

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
	var midi_data = load_midi()
	print(midi_data)
	
	

func _input(input_event):
	if input_event is InputEventMIDI:
		if input_event.message == 9:
#			_print_midi_info(input_event)
#			var new_note = note.instantiate(PackedScene.GEN_EDIT_STATE_MAIN)
			var new_note = Note.new(str(input_event.pitch))
			new_note.position.x = randi_range(1, 8) * 130
			new_note.position.y = 30
			
			add_child(new_note)
			print("New note")

func _print_midi_info(midi_event: InputEventMIDI):
	print(midi_event)
	print("Channel " + str(midi_event.channel))
	print("Message " + str(midi_event.message))
	print("Pitch " + str(midi_event.pitch))
	print("Velocity " + str(midi_event.velocity))
	print("Instrument " + str(midi_event.instrument))
	print("Pressure " + str(midi_event.pressure))
	print("Controller number: " + str(midi_event.controller_number))
	print("Controller value: " + str(midi_event.controller_value))
	
func _process(delta):
	var temp_child_count = get_child_count()
	if child_count != temp_child_count:
		child_count = temp_child_count
		print("Child count: %s" % child_count)
