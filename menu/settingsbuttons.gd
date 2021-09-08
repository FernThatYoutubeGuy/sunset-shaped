extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var text = $RichTextLabel2
# Called when the node enters the scene tree for the first time.
#func _ready():
	#_on_play_focus_exited()

func _on_TextureButton_focus_entered():
	text.modulate = "#FFCDB2"


func _on_TextureButton_focus_exited():
	text.modulate = "#e5989b"
