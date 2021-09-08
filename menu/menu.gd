extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var info = get_parent().get_node("info")
onready var settings = get_parent().get_node("settings")
onready var end = get_parent().get_node("end")
onready var base = get_node("/root/base")
onready var click = get_parent().get_node("clicksound")
onready var endtext = get_parent().get_node("end/text")
onready var pause = get_parent().get_node("pause")
onready var levelreset = get_parent().get_node("levelconfirm")
onready var gamereset = get_parent().get_node("gameconfirm")
onready var leveltimer = get_parent().get_node("leveltimer")
onready var levels = get_parent().get_node("levels")
onready var leveltime = leveltimer.get_node("text")
var currentmenu = "none"
# Called when the node enters the scene tree for the first time.
func _ready():
	$play.grab_focus()
	visible = true
	info.visible = false
	settings.visible = false
	end.visible = false
	pause.visible = false
	levelreset.visible = false
	gamereset.visible = false

func end_text():
	
	print(base.timer)
	print(base.leveltime[0] + base.leveltime[1] + base.leveltime[2] + base.leveltime[3] + base.leveltime[4])
	var taken = make_time(base.timer)
	
	var deaths = base.deaths


	endtext.bbcode_text = """[center]thank you for playing [color=#FFB4A2]sunset-shaped[/color] by [color=#FFB4A2]bucketfish[/color].

time - %s
deaths - %s
[color=#FFB4A2]stay safe.[/color]""" % [taken, str(deaths)]

	if base.mode == "level":
		end.get_node("title").bbcode_text = "[center]level " + str(base.level) + "."
	else:
		end.get_node("title").bbcode_text = "the end."
		
	var leveltimings = []
	var count:float = 0
	
	for i in range(5):
		leveltimings.append(make_time(base.leveltime[i]))
		
	leveltime.bbcode_text = """[center]per-level timer:
level 1 - %s
level 2 - %s
level 3 - %s
level 4 - %s
level 5 - %s
	""" % leveltimings

func make_time(timetaken):
	var taken = stepify(timetaken, 0.01)
	
	var hr = floor(taken/3600)
	var mn = floor(taken/60) - (hr * 60)
	var sc = floor(taken) - (mn*60) - (hr*3600)
	var mls = fmod(taken,1) * 100
	
	if hr == 0:
		return "%02d:%02d.%02d" % [mn, sc, mls]
	else:
		return "%d:%02d:%02d.%02d" % [hr, mn, sc, mls]


func _on_play_pressed():
	
	click.play()
	base._play()


func _on_info_pressed():
	click.play()
	visible = false
	info.visible = true
	currentmenu = "info"
	info.get_node("back").grab_focus()




func _on_back_pressed():
	click.play()
	info.visible = false
	end.visible = false
	settings.visible = false
	visible = true
	if currentmenu == "info":
		$info.grab_focus()
		currentmenu = "none"
	elif currentmenu == "settings":
		$settings.grab_focus()
		currentmenu = "none"


func _on_quit_pressed():
	click.play()
	base.anim.play("fade")
	base.music_anim.play("fade")
	yield(base.anim, "animation_finished")
	get_tree().quit()




func _on_continue_pressed():
	click.play()
	base.unpause()
	


func _on_quittomenu_pressed():
	click.play()
	base.anim.play("fade")
	yield(base.anim, "animation_finished")
	pause.visible = false
	_ready()
	base.anim.play_backwards("fade")


func _on_levelreset_pressed():
	click.play()
	pause.visible = false
	levelreset.visible = true
	levelreset.get_node("continue").grab_focus()


func _on_levelconfirm_pressed():
	click.play()
	base._resetlevel()


func _on_backtopause_pressed():
	click.play()
	levelreset.visible = false
	gamereset.visible = false
	pause.visible = true
	pause.get_node("continue").grab_focus()
	


func _on_gamereset_pressed():
	click.play()
	pause.visible = false
	gamereset.visible = true
	gamereset.get_node("continue").grab_focus()


func _on_gameconfirm_pressed():
	click.play()
	base._play()

func _hideall():
	visible = false
	info.visible = false
	settings.visible = false
	end.visible = false
	pause.visible = false
	levelreset.visible = false
	gamereset.visible = false
	levels.visible = false
	leveltimer.visible = false


func _on_leveltime_pressed():
	click.play()
	end.visible = false
	leveltimer.visible = true
	leveltimer.get_node("back").grab_focus()


func _on_endback_pressed():
	click.play()
	leveltimer.visible = false
	end.visible = true
	end.get_node("leveltime").grab_focus()


func _on_levels_pressed():
	click.play()
	visible = false
	levels.visible = true
	levels.get_node("1").grab_focus()
	

func _on_levelselect(level):
	click.play()
	base._playlevel(level)


func _on_levelback_pressed():
	click.play()
	visible = true
	levels.visible = false
	$levels.grab_focus()


func _on_settings_pressed():
	click.play()
	visible = false
	info.visible = false
	end.visible = false
	pause.visible = false
	settings.visible = true
	currentmenu = "settings"
	settings.get_node("back").grab_focus()
