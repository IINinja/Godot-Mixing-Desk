extends Node2D

var dvols = []
var dpitches = []

export var volume_range : float
export var pitch_range : float

func _ready():
	for i in get_children():
		dvols.append(i.volume_db)
		dpitches.append(i.pitch_scale)

func _iplay(sound):
	var snd = sound.duplicate()
	sound.add_child(snd)
	snd.play()
	yield(snd, "finished")
	snd.queue_free()
	
func _play(ran=true):
	for i in get_children():
		if ran:
			_randomise_pitch_and_vol(i)
		_iplay(i)
		
func _randomise_pitch_and_vol(sound):
	var dvol = sound.get_parent().dvols[sound.get_index()]
	var dpitch = sound.get_parent().dpitches[sound.get_index()]
	var newvol = (dvol + rand_range(-volume_range,volume_range))
	var newpitch = (dpitch + rand_range(-pitch_range,pitch_range))
	sound.volume_db = newvol
	sound.pitch_scale = newpitch