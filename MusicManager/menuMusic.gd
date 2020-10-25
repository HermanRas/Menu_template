extends AudioStreamPlayer

func _ready():
	stream = load('res://Assets/sound/copycat.ogg')
	volume_db = 20.0
	playing = true
