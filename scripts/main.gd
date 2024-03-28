extends Node

const FALL_GUY: PackedScene = preload("res://scenes/fall_guy.tscn")
var UPGRADES: Array[Node]

var dabloons: Big


func click() -> void:
	for i in range(min(UPGRADES[1].level + 1, 10)):
		for j in range(min(UPGRADES[0].level + 1, 10)):
			var fall = FALL_GUY.instantiate()
			fall.position = $fall_guys_pos.position
			add_child(fall)
			fall.emitting = true
		$Path2D.advance = !$Path2D.advance
	var tmp: Big = Big.new(0)
	tmp = tmp.plus(UPGRADES[0].level + 1)
	tmp = tmp.times(UPGRADES[1].level + 1)
	tmp = tmp.toThePowerOf((UPGRADES[2].level / 10) + 1)
	dabloons = dabloons.plus(tmp)


func load_game() -> Dictionary:
	var file = FileAccess.open("user://door_clicker_data.json", FileAccess.READ)
	if not file:
		return {}
	var content = file.get_as_text()
	return JSON.parse_string(content)


func save_game() -> void:
	var tmp = {
		"dabloons": dabloons.toString(),
		"upgrades": {}
	}
	for up in range(len(UPGRADES)):
		tmp["upgrades"][up] = {
			"level": UPGRADES[up].level
		}
	var file = FileAccess.open("user://door_clicker_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(tmp, "    "))


func _ready() -> void:
	UPGRADES = $UI/ScrollContainer/VBoxContainer.get_children()
	var loading = load_game()
	if loading.keys():
		dabloons = Big.new(loading["dabloons"])
		for up in loading["upgrades"]:
			UPGRADES[int(up)].level = loading["upgrades"][up]["level"]
	else:
		dabloons = Big.new(0)
	dabloons.setSmallDecimals(1)
	$Path2D.generate_line = true
	_on_check_button_pressed()


func _on_click_gui_input(event: InputEvent) -> void:
	if ((event is InputEventMouseButton and event.button_index == 1) or event is InputEventScreenTouch) and event.is_pressed():
		click()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("debug"):
		click()
	$UI/clicks.text = dabloons.toAA() + " Dabloons"


func _on_check_button_pressed() -> void:
	$AudioStreamPlayer.playing = $UI/CheckButton.is_pressed()


func _on_save_pressed() -> void:
	save_game()
